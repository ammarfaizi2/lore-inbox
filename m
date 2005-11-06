Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVKFU4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVKFU4V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 15:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVKFU4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 15:56:21 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:62526 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750853AbVKFU4V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 15:56:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JgS3I53nbOGm7TqsOKyhqKSvl5m181QlkhAsUNC9876rmisnwpaxtMLP5Qj1ANOBzby3E7WFRRei2q+21UNqItTrFkzR8M+m/UGKeqHdYd3+0p7z4tm7zO9Apt5ln+K5B/Rvvs/XpOSfexFnX4SgsQnv0JikaYzXf0/Ak5m5uSE=
Message-ID: <8413367b0511061256u565de887jf5819ff9b3b4030c@mail.gmail.com>
Date: Sun, 6 Nov 2005 21:56:20 +0100
From: <grfgguvf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Whys and hows of initrds
In-Reply-To: <436E4FDF.7000503@mnsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8413367b0511060924s550024b8w1113564cd6bb9340@mail.gmail.com>
	 <436E4FDF.7000503@mnsu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/05, Jeffrey Hundstad wrote:
> boot process to continue.  It MAY also mount a network file system and
> boot from that.

But the kernel can do that without an initrd as well.

> >* What are the differences between an initrd and an initramdisk (if
> >any)? And an initramfs?
> >
> There is a nice read post not that long ago comparing some of them, you
> may want to scan lat months archives.  It was a documentation patch...

I will look around. Thanks!

> Other OSes just load everything; which isn't very efficient.

FreeBSD (for example) has a bootloader that can load arbitrary modules
in addition to the kernel.
Is there anything preventing that to be done with Linux? Or is it just
not powerful enough?
