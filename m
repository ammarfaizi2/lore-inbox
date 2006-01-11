Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWAKIaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWAKIaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWAKIaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:30:09 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:50594 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751382AbWAKIaH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:30:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d0dCo3TubPJcTRPYQOiAd4xKvQHBLuFTntV3fIIlZrm0OEAwi4pBelj0V/V4JaINrciVmJF7U2l0fDLSIM9001E9GproN+iqmBlMtoOu5AyVoZGk1Op7z+QBfgBI2+WeXsdNh0XkiLIw6IE11J/U0JqhCMx2QhYuiplj+tlwCYE=
Message-ID: <5a2cf1f60601110030u358c12fcscf79067cbc3eebe0@mail.gmail.com>
Date: Wed, 11 Jan 2006 09:30:07 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ata errors -> read-only root partition. Hardware issue?
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43C4493A.4010305@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5ttip-Xh-13@gated-at.bofh.it> <43C4493A.4010305@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Robert Hancock <hancockr@shaw.ca> wrote:
> jerome lacoste wrote:
> >
> > ata3: status=0x51 { DriveReady SeekComplete Error }
> > ata3: error=0x40 { UncorrectableError }
> > ata3: status=0x51 { DriveReady SeekComplete Error }
> > ata3: error=0x40 { UncorrectableError }
> > ata3: status=0x51 { DriveReady SeekComplete Error }
> > ata3: error=0x40 { UncorrectableError }
> > SCSI error : <2 0 0 0> return code = 0x8000002
> > sda: Current: sense key: Medium Error
> >     Additional sense: Unrecovered read error - auto reallocate failed
> > end_request: I/O error, dev sda, sector 67801511
>
> That sounds an awful lot like a failing hard drive.

Thanks Robert,

So what is the procedure in Linux to test for these problems?
I was thinking:
- scan for bad blocks
- maybe check the SMART results if they are available
- memory check: memtest86 & memtest86+ tests (just in case)

Anything I missed?

Does someone know a diagnostics utilities CD (a la Dell diagnostics)
that you can boot on your PC, let run for x hours and get feedback?

Cheers,

Jerome
