Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWISWRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWISWRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWISWQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:16:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:6219 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751225AbWISWQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:16:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=erA5CA9kUrExHFptB8rnhxL4kp1FD5AZFC9Um53kozUIavCKVX+tO7By97mmss4PkL0jdNrQkzVLrx/aHM2tr2uCol1UyFXaqqwHkJ2kI9TMVGMzCTlUHPz5epwY2g36StAsKAF25QK3GGtuZpWvjWpOKX+6Wyx6s3KqGBLn+HU=
Message-ID: <9a8748490609191516x4305c67dy76ac742e92f08ced@mail.gmail.com>
Date: Wed, 20 Sep 2006 00:16:57 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Math-emu kills the kernel on Athlon64 X2
Cc: "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <p73venk2sjw.fsf@verdi.suse.de>
	 <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
	 <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 19 Sep 2006, Jesper Juhl wrote:
> >
> > The config is attached.
>
> Can you try without SMP, and with CONFIG_X86_GENERIC

Done. The result is exactely the same as before. The kernel boots and
runs just fine except when I add "no387" to the boot options, then it
hangs.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
