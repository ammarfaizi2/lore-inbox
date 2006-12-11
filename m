Return-Path: <linux-kernel-owner+w=401wt.eu-S1762906AbWLKN0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762906AbWLKN0d (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762904AbWLKN0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:26:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:45690 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762906AbWLKN0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:26:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TQEV0Sxrq5aTlP2YIyUh1+PZGZYKQ+RwcGS0NVT/CVKjSpYyBDTIaVm/rHc0PpncFDTYrFYxfmNHnehrTvI+BGf8EgUIqm3iuNEFOkoYCGJyy9DQ9+IQ59STypOsorVGORo0ayNKUXNUgWgY2Qi4F/hx3LteDAmPccX86jAtx+U=
Message-ID: <5a4c581d0612110526j26a07b31q26edc075d4981cd8@mail.gmail.com>
Date: Mon, 11 Dec 2006 14:26:30 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related [still in -git17]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/06, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> On 12/3/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > > > ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ5
> > > > PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> > > > ata_piix: probe of 0000:00:1f.2 failed with error -16
> > > > [snip]
> > > > mount: could not find filesystem '/dev/root'
> > >
> > > Same failure is also in 2.6.19-git4...
> >
> > Thats the PCI updates - you need the matching fix to libata-sff where it
> > tries to reserve stuff it shouldn't.
>
> Thanks Alan. Indeed -git1 is where stuff breaks for me.
> I'll watch out for when libata-sff gets fixed in the -git
>  snapshots and will then report back.

Alan,

  I still have this problem in 2.6.19-git17. Is this expected behavior
  or should it have been fixed by now ?

Thanks,

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
