Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTDWNwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbTDWNwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:52:51 -0400
Received: from USAMAIL2.conoco.com ([12.31.208.227]:36366 "EHLO
	usamail2.conoco.com") by vger.kernel.org with ESMTP id S264043AbTDWNwt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:52:49 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.4.21-pre5 : hw tcp v4 csum failed
Date: Wed, 23 Apr 2003 09:04:50 -0500
Message-ID: <5CA6F03EF05E0046AC5594562398B916D32EB6@POEXMB3.conoco.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.21-pre5 : hw tcp v4 csum failed
Thread-Index: AcMI7BkXXYWGEJ95RASEpAiAfCcA0gADKUYQ
From: "Heflin, Roger A." <Roger.A.Heflin@conocophillips.com>
To: =?iso-8859-1?Q?Philippe_Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: <linux-poweredge@dell.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Apr 2003 14:04:51.0454 (UTC) FILETIME=[4EE549E0:01C309A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a number of 2650's running 2.4.21pre4 and don't appear to be
getting that error, we have not tried pre5 as of yet.

Our tg3 version is 1.2a.

			Roger

> -----Original Message-----
> From:	Philippe Gramoullé [SMTP:philippe.gramoulle@mmania.com]
> Sent:	Tuesday, April 22, 2003 11:13 AM
> To:	jgarzik@pobox.com
> Cc:	linux-poweredge@dell.com; linux-kernel@vger.kernel.org
> Subject:	2.4.21-pre5 : hw tcp v4 csum failed
> 
> 
> Hello,
> 
> I just saw that we've been having those messages on at least 4 DELL 2650 ( running tg3 driver version 1.4c)
> running busy FTP servers ( all in the same load balanced FTP farm )
> 
> ftp1 # egrep -c "hw tcp v4 csum failed" /var/log/kern.log
> 1846
> 
> for the last 3 days.
> 
> The box is running 2.4.21-pre5.
> 
> Is this a known problem ? ( i've seen that driver 1.5 is available BTW)
> or more likely a network issue ?
> 
> Thanks,
> 
> Philippe
> 
> _______________________________________________
> Linux-PowerEdge mailing list
> Linux-PowerEdge@dell.com
> http://lists.us.dell.com/mailman/listinfo/linux-poweredge
> Please read the FAQ at http://lists.us.dell.com/faq or search the list archives at http://lists.us.dell.com/htdig/
