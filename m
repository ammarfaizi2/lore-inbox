Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVIWUA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVIWUA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVIWUAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:00:55 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:20632 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751196AbVIWUAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:00:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ohCJtBkkHwzMDHjmpAiI9An3rBe8SALxKbqP/BSBP7zlVAfgFQCDb0f3uyy3xZMd0G3yKuSfjuu9dR24sCvMQPWs5u8tTpHNUPqkqic8eFneEtSOpQf/ylIdQ1lWAu+gf1lCC1i7zYiRzk2c8wuFnq/P8Zdl3ulFfoyUY/T9guI=
Date: Sat, 24 Sep 2005 00:11:20 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Sykes <chris@sigsegv.plus.com>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-ID: <20050923201119.GA9319@mipter.zuzino.mipt.ru>
References: <20050922163708.GF5898@sigsegv.plus.com> <20050923015719.5eb765a4.akpm@osdl.org> <20050923121932.GA5395@sigsegv.plus.com> <20050923132216.GA5784@sigsegv.plus.com> <20050923121811.2ef1f0be.akpm@osdl.org> <9a8748490509231245d26d875@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490509231245d26d875@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 09:45:37PM +0200, Jesper Juhl wrote:
> On 9/23/05, Andrew Morton <akpm@osdl.org> wrote:
> > We ought to have the git bisection process documented in the kernel tree,
> > but we don't, alas.  There's stuff at http://lkml.org/lkml/2005/6/24/234
> > but a standalone document which walks people through installing git,
> > pulling the initial tree, building and bisecting is needed (hint).
> >
> 
> If noone else is doing this then I'll write such a document.
> If someone has already started writing it, then please let me know so
> we don't duplicate work. I'll get write it during the weekend if I
> hear nothing.

Bisecting itself is described at Documentation/git-bisect.txt:

http://kernel.org/git/?p=git/git.git;a=blob;h=b124b0751c195db82a49d0bcf434da429ec71019;hb=7fe2fc79358673a909d71e62d3f80ffe0f525fce;f=Documentation/git-bisect.txt

