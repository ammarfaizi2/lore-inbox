Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424594AbWKPXpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424594AbWKPXpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424595AbWKPXpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:45:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41169 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1424594AbWKPXpp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:45:45 -0500
Date: Thu, 16 Nov 2006 23:50:48 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Ioan Ionita" <opslynx@gmail.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, htejun@gmail.com,
       alan@redhat.com
Subject: Re: 2.6.19-rc5 libata PATA ATAPI CDROM SiS 5513 NOT WORKING
Message-ID: <20061116235048.3cd91beb@localhost.localdomain>
In-Reply-To: <df47b87a0611161522o3ad007f5i8804c876c50e591c@mail.gmail.com>
References: <df47b87a0611161522o3ad007f5i8804c876c50e591c@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 18:22:47 -0500
"Ioan Ionita" <opslynx@gmail.com> wrote:

> I gave libata a shot. Hardisk works fine. However the CDROM doesn't.
> It would seem that the CDROM is detected, but the device node is not
> created.
> 
> I do have libata.atapi_enabled=1 as a kernel parameter. This is a Vaio
> laptop, with SiS 5513, PATA only, no SATA ports.
> 
> Did I miss anything?

>From the trace looks like the SCSI CD-ROM Driver is not compiled in
and/or loaded.

