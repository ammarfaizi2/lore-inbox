Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWB1SJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWB1SJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWB1SJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:09:04 -0500
Received: from khc.piap.pl ([195.187.100.11]:8452 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932385AbWB1SJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:09:02 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
       <col-pepper@piments.com>, <linux-kernel@vger.kernel.org>
Subject: Re: o_sync in vfat driver
References: <op.s5lq2hllj68xd1@mail.piments.com>
	<20060227132848.GA27601@csclub.uwaterloo.ca>
	<1141048228.2992.106.camel@laptopd505.fenrus.org>
	<1141049176.18855.4.camel@imp.csi.cam.ac.uk>
	<1141050437.2992.111.camel@laptopd505.fenrus.org>
	<1141051305.18855.21.camel@imp.csi.cam.ac.uk>
	<op.s5ngtbpsj68xd1@mail.piments.com>
	<Pine.LNX.4.61.0602271610120.5739@chaos.analogic.com>
	<op.s5nm6rm5j68xd1@mail.piments.com>
	<Pine.LNX.4.61.0602280745500.9291@chaos.analogic.com>
	<20060228151856.GB27601@csclub.uwaterloo.ca>
	<Pine.LNX.4.61.0602281110460.4497@chaos.analogic.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 28 Feb 2006 19:09:00 +0100
In-Reply-To: <Pine.LNX.4.61.0602281110460.4497@chaos.analogic.com> (linux-os@analogic.com's
 message of "Tue, 28 Feb 2006 11:16:30 -0500")
Message-ID: <m3bqwr8if7.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> Here is an instrumented erase function on a driver that rewrites
> the first sector of a BIOS ROM. Unlike the Flash DISKS, the
> BIOS ROM has no buffering in static RAM so you can gustimate
> the actual time to erase............

The NOR flash is different but Samsung manual for K9F5608U0A-YCB0,
K9F5608U0A-YIB0 32M x 8 Bit NAND Flash Memory says:

FEATURES GENERAL DESCRIPTION
- Page Program : (512 + 16)Byte
- Block Erase : (16K + 512)Byte
- Program time : 200us(Typ.)
- Block Erase Time : 2ms(Typ.)
- Endurance : 100K Program/Erase Cycles
- Data Retention : 10 Years
-- 
Krzysztof Halasa
