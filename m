Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWDSWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWDSWVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWDSWVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:21:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:10266 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751172AbWDSWVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:21:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t6OKV3bqGgjWqsFBLcNm63+IUZ1l1z2ZQtOULB07rEo3JOoE9xaRa2LFtLABEdWb1MZHAL4rj46yiWeC7H4f7glY7ZjVakX0neZSY9grQSLkrrKe9iF9mXYlLcLAczbpHhRB80E+n8/om8y4oJ7I2wErMXZymJgg937DTiZIutk=
Message-ID: <9a8748490604191521g7e4b49e8mcf01996d3b2c4e21@mail.gmail.com>
Date: Thu, 20 Apr 2006 00:21:33 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Tilman Schmidt" <tilman@imap.cc>
Subject: Re: [PATCH] ISDN: unsafe interaction between isdn_write and isdn_writebuf_stub
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44457350.4040802@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <60xlD-5Y2-13@gated-at.bofh.it> <62rF9-2nN-7@gated-at.bofh.it>
	 <44457350.4040802@imap.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, Tilman Schmidt <tilman@imap.cc> wrote:
> On 17.04.2006 04:30, Jesper Juhl wrote:
> > No replies to this patch (below) at all, despite lots of people and
> > lists on CC :-(
> > Ohh well, adding akpm to CC so that perhaps the patch can make it into
> > -mm and at least get some testing.
>
> Yeah, apparently nobody wants to put much work into i4l anymore.

So it would seem.

> Everybody's waiting for it to be replaced by CAPI, only we don't quite
> seem to be there yet.
>
I don't know the state of that, but as long as the i4l stuff is in the
kernel I think we should try to fix bugs when we find them, so I'll
just try to push the patch again in a while.


> Anyway, my development machine has been running with your patch for a
> while, with no apparent ill effects. Although this hardly qualifies as
> exhaustive testing, it does seem do indicate that the patch is on the
> right track.
>
Thanks a lot for trying the patch and your feedback, I really appreciate it.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
