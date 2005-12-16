Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVLPPyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVLPPyI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVLPPyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:54:08 -0500
Received: from mail29.messagelabs.com ([140.174.2.227]:23447 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S932334AbVLPPyH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:54:07 -0500
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-11.tower-29.messagelabs.com!1134748434!27893444!1
X-StarScan-Version: 5.5.9.1; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Support for Digi Neo 8p board in jsm driver
Date: Fri, 16 Dec 2005 09:53:53 -0600
Message-ID: <335DD0B75189FB428E5C32680089FB9F36B3D0@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Support for Digi Neo 8p board in jsm driver
Thread-Index: AcYCTsOx473ZsjSgRYe17AdlVKYKOwACJLMw
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Adrian Bunk" <bunk@stusta.de>,
       "Alexander V. Inyukhin" <shurick@sectorb.msk.ru>
Cc: <linux-kernel@vger.kernel.org>,
       "Ananda K Venkataraman" <avenkat@us.ibm.com>
X-OriginalArrivalTime: 16 Dec 2005 15:53:54.0255 (UTC) FILETIME=[EA937DF0:01C60258]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex, all,

> Jsm driver is claimed to support Digi Neo multiport
> serial boards but according to PCI id table
> only 2port boards are supported.
> 
> Is it possible to support other Digi Neo boards by jsm
> or original dgnc driver should be used instead?

Either the in-tree JSM driver or the out-of-tree DGNC driver will work
fine.

The out-of-tree DGNC driver was the intended driver to be used with
the all the various Digi Neo boards.

The JSM driver was intended to be used with only the 2 port Digi Neo
board,
however, I am not aware of any reason why the 8 port wouldn't work as
well.

If you use the JSM driver, you will need to update the PCI id table
in the JSM driver to add in the 8 port PCI ID.

Scott
