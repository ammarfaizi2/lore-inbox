Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVJTU1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVJTU1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 16:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVJTU1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 16:27:31 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:39624 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932524AbVJTU1a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 16:27:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cB5SogHYL/OLfd+rMsrG3S242jZkxTS+9RdmArixE3cwcr/BJwg9dKnRiy7hyEXkSaJ7uWCM9ABEjiXhUtER3ffBBWwzLYTak29yIUnSdoafSZr9B67wn2ukVRDH6i5+OeqCkO9q2ZnCX/6IQtQyPQNGDs+PJNsaCNk1cf8hEwA=
Message-ID: <b6c5339f0510201327j2a9f0865o698f31e5ca0de16d@mail.gmail.com>
Date: Thu, 20 Oct 2005 16:27:29 -0400
From: Bob Copeland <email@bobcopeland.com>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Subject: Re: [PATCH] fix vgacon blanking
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051020161311.GA30041@ojjektum.uhulinux.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051020161311.GA30041@ojjektum.uhulinux.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/05, Pozsar Balazs <pozsy@uhulinux.hu> wrote:
> Hi all,
>
> This patch fixes a long-standing vgacon bug: characters with the bright
> bit set were left on the screen and not blacked out.
> All I did was that I lookuped up some examples on the net about setting
> the vga palette, and added the call missing from the linux kernel, but
> included in all other ones. It works for me.

Thanks for this.  Looks like the palette mask is set to something funky.  I had
the same problem on my machine but never got annoyed enough to poke
around in the code.

-Bob
