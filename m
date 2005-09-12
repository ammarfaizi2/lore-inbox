Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVILMXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVILMXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVILMXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:23:38 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:47878 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750779AbVILMXh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:23:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050912110712.GA287@DervishD>
References: <1126462329.4324737923c2d@wmtest.cc.vt.edu> <1126462467.43247403c2e1c@wmtest.cc.vt.edu> <43250150.20308@metaparadigm.com> <200509121249.40467.vda@ilport.com.ua> <20050912110712.GA287@DervishD>
X-OriginalArrivalTime: 12 Sep 2005 12:23:36.0143 (UTC) FILETIME=[CC5A25F0:01C5B794]
Content-class: urn:content-classes:message
Subject: Re: Universal method to start a script at boot
Date: Mon, 12 Sep 2005 08:23:29 -0400
Message-ID: <Pine.LNX.4.61.0509120817440.22714@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Universal method to start a script at boot
Thread-Index: AcW3lMxj7sCvqfrgSmmJmW/xeuCHUA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "DervishD" <lkml@dervishd.net>
Cc: "Denis Vlasenko" <vda@ilport.com.ua>,
       "Michael Clark" <michael@metaparadigm.com>,
       "Brad Tilley" <rtilley@vt.edu>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Sep 2005, DervishD wrote:

>    Hi Denis :)
>
> * Denis Vlasenko <vda@ilport.com.ua> dixit:
>> Awful. This codifies ages-old Unix traditional SysV-like init
>> and its derivatives, which should be get rid of instead.
>
>    I'm with you in this, in fact I use my own init system, but...
>
>> daemontools are absolutely wonderful way of controlling daemons.
>
>    How the heck you make sure that svscan starts the services in the
> correct order? Does it run the services in /services in any
> particular order or just in the order resulting for a simple
> globbing? How you make sure the services are shut down in any
> particular order?
>
>    All this seems like requiring scripts to do the job (that is,
> ensuring a particular order of startup/shutdown), while sysvinit
> gets this info from filenames. Obviously, dictating the order using a
> script is far more flexible than using filenames but it's not as
> simple, and that cannot be seen in the comparisons D.J.B. does in the
> homepage of daemontools (which, BTW, is the only source of
> documentation, and a very poor one). LSB, on the other hand, is
> better structured and although I don't like sysvinit at all, the
> system is better documented. And I hate runlevels...
>
>    Raúl Núñez de Arenas Coronado

The embedded systems we use have a "home-made" `init` that
does everything in the coded order. This means that there is
no shell so the system can't be hacked in the usual ways.
Also, some technician in "final test" can't forget to do
something that results in a disaster once a system is in
the field. If the system runs, it's running in its intended
manner.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
