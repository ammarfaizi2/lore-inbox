Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWDYKyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWDYKyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWDYKyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:54:33 -0400
Received: from mail-gw2.adaptec.com ([216.52.22.42]:29413 "EHLO
	aimspam2.adaptec.com") by vger.kernel.org with ESMTP
	id S932197AbWDYKya convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:54:30 -0400
X-ASG-Debug-ID: 1145962689-24643-163-0
X-Barracuda-URL: http://192.168.92.161:8000/cgi-bin/mark.cgi
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
X-ASG-Orig-Subj: RE: HEADS UP for gdth driver users
Subject: RE: HEADS UP for gdth driver users
Date: Tue, 25 Apr 2006 12:54:28 +0200
Message-ID: <EF6AF37986D67948AD48624A3E5D93AFAA960D@mtce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HEADS UP for gdth driver users
Thread-Index: AcZoU7dvQqyUyKgyTAOAak4U8CB8rAAAq5+A
From: "Leubner, Achim" <Achim_Leubner@adaptec.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: <linux-kernel@vger.kernel.org>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=3.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.11376
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help. I will make the patch, test it and send it out as
soon as possible to put it into the 2.6.18 cycle.

Thanks,
Achim

=======================
Achim Leubner
Software Engineer / RAID drivers
ICP vortex GmbH / Adaptec Inc.
Phone: +49-351-8718291
 
-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Dienstag, 25. April 2006 12:33
To: Leubner, Achim
Cc: Christoph Hellwig; linux-kernel@vger.kernel.org
Subject: Re: HEADS UP for gdth driver users

On Mon, Apr 24, 2006 at 02:21:00PM +0200, Leubner, Achim wrote:
> Is there any news on that? Can we use the scsi_get/put_command()
functions for allocating a "struct scsi_cmnd" or should we allocate it
with kmalloc() or somehow like that? Or, Christoph, did you already make
the second patch for the gdth driver? 
> We want to bring the gdth driver up to date as soon as possible. Any
help is greatly appreciated! 
Sorry, I didn't have time to look at this yet.  scsi_get/put_command()
sems ok for now, if you have time to look at this now it would be good
if you could look at it.  It's too late for 2.6.17 already, but having
it early in the 2.6.18 cycle would be very helpful.



