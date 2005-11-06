Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVKFXfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVKFXfv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVKFXfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:35:51 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:59317 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751291AbVKFXfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:35:50 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: grfgguvf@gmail.com
Subject: Re: Whys and hows of initrds
Date: Sun, 6 Nov 2005 23:35:34 +0000
User-Agent: KMail/1.8.92
Cc: linux-kernel@vger.kernel.org
References: <8413367b0511060924s550024b8w1113564cd6bb9340@mail.gmail.com>
In-Reply-To: <8413367b0511060924s550024b8w1113564cd6bb9340@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511062335.34520.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 November 2005 17:24, grfgguvf@gmail.com wrote:
> Hi,
> I don't know if the LKML is a technical kernel development list or a
> newbie support list (or both?) so maybe I'm posting to the wrong
> place.
>
> Questions:
> * Why is an initrd needed?
> * What does it do?

Though there are reasons beyond this, ultimately an initrd is useful primarily 
to distributors, who provide too many drivers to build them all in (the 
resulting kernel image would be too large to boot).

In particular, filesystem, RAID and SCSI drivers (required for rootfs to exist 
before calling onto init), are put into such an image.

> * What are the differences between an initrd and an initramdisk (if
> any)? And an initramfs?
> * Why cannot the task of initrds be done more easily?

> * Why don't other operating systems need an equivalent? Or do they?
>
> Opinions and technical explanations welcome. Please, no excessive flames!

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
