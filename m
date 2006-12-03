Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759889AbWLCWbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759889AbWLCWbu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759899AbWLCWbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:31:50 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:56401 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1759889AbWLCWbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:31:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IZ8M3Lz7nmTQWYWRO3WmwWXlsKdW6DU+QmB0IVt3cvR+TU1YFSEAbSzOcRMhN7rKbxP73uq4qXGvq2jAAthWVRN7/wJy8EcznWOiw2VvjaeWykBGMrSLx6ckq6F9zZHtoKwnLpl7nUejRBnRpBqye4aaFWskXt8W2L30YKb5xao=
Message-ID: <5a4c581d0612031431n2849d93dw13a831cd28a8a746@mail.gmail.com>
Date: Sun, 3 Dec 2006 23:31:48 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061203223608.037a6d58@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0612031056r1eca228fp872276f3df7a07a2@mail.gmail.com>
	 <5a4c581d0612031331v478f7a21paf29665130282b1f@mail.gmail.com>
	 <20061203223608.037a6d58@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > > ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ5
> > > PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> > > ata_piix: probe of 0000:00:1f.2 failed with error -16
> > > [snip]
> > > mount: could not find filesystem '/dev/root'
> >
> > Same failure is also in 2.6.19-git4...
>
> Thats the PCI updates - you need the matching fix to libata-sff where it
> tries to reserve stuff it shouldn't.

Thanks Alan. Indeed -git1 is where stuff breaks for me.
I'll watch out for when libata-sff gets fixed in the -git
 snapshots and will then report back.

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
