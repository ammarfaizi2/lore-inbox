Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWEJQYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWEJQYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWEJQYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:24:17 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:28357 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965023AbWEJQYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:24:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lznbN3ohV5L+wkEP63tduqjhfa0/JAC+sV8njARrnHv4jO0FxYxs3Ki3Vm28GMMw5QSgRxTZaDns6NZYmQcmluaJligQ3GILTBVEGzuTIglTZDzm8xd4XUQL+e4DJBIQwV0FdZQiQQIkKJNdjZMMd0hczhrsjEafz8msWTMvXqg=
Message-ID: <bda6d13a0605100924u12270e3dh5f6b519ee0d0b14f@mail.gmail.com>
Date: Wed, 10 May 2006 09:24:09 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Anton Altaparmakov" <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Not mounting NTFS rw, 2.6.16.1, but does so on 2.6.15
In-Reply-To: <Pine.LNX.4.64.0605100957040.28166@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0605092320y5cca6e1co2228f52c9777c3b1@mail.gmail.com>
	 <Pine.LNX.4.64.0605100957040.28166@hermes-1.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> On Tue, 9 May 2006, Joshua Hudson wrote:
> > which means cannot re-run lilo on my laptop, so Not progressing beyond
> > 2.6.15 until fixed.
> > Downloading 2.6.16.15 to try that version now.
> >
> > 16kstacks patch was applied (I use ndiswrapper with broadcom drivers loaded).
>
> What are the error messages?  (Run dmesg to find out.)
>
> Best regards,
>
>         Anton

Verified on 2.6.16.15. 16kstacks applied. ndiswrapper not loaded.

Dmesg:

[snip]
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS volume version 3.1.
NTFS-fs warning (device hdc1): load_system_files(): Unsupported volume
flags 0x4000 encountered.
NTFS-fs error (device hdc1): load_system_files(): Volume has
unsupported flags set.  Mounting read-only.  Run chkdsk and mount in
Windows.
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 7 (level,
low) -> IRQ 7
[snip]

Yes, I know. This machine: boot disk = /dev/hdc, cdrom = /dev/hda
