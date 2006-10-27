Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752240AbWJ0PBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbWJ0PBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbWJ0PBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:01:33 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:16777 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1752231AbWJ0PBc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:01:32 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-16.tower-29.messagelabs.com!1161961175!27641984!7
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: removing drivers and ISA support? [Was: Char: correct pci_get_device
Date: Fri, 27 Oct 2006 10:01:00 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F804012@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: removing drivers and ISA support? [Was: Char: correct pci_get_device
Thread-Index: Acb52LbEYhr/yUcIQ/Ws87+YWq0l/g==
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 27 Oct 2006 15:01:00.0744 (UTC) FILETIME=[B7236480:01C6F9D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, all,

Alan Cox:
> I think some of the drivers like epca we should seriously consider
> dropping and seeing if there is any complaint, my guess will be not.

You sure won't have any compliants from Digi International about
removing
the epca driver from the kernel tree.

That driver is *ancient* and I suspect no one actually uses it.
(I am not sure its even useable in the current form in the kernel tree)

We (Digi) have a much newer "PCI-only, rewritten for 2.6.x" open source
version of the driver called "dgap" that all our customers use now
instead.

Scott Kilau
