Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTD2C2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 22:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbTD2C2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 22:28:51 -0400
Received: from adsl-68-74-104-142.dsl.klmzmi.ameritech.net ([68.74.104.142]:15620
	"EHLO tabriel.tabris.net") by vger.kernel.org with ESMTP
	id S261214AbTD2C2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 22:28:50 -0400
From: Tabris <tabris@sbcglobal.net>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: 2.4.21-rc1-ac2 Promise IDE DMA won't work
Date: Mon, 28 Apr 2003 22:34:59 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <Pine.LNX.4.10.10304281855540.20264-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10304281855540.20264-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304282234.59745.tabris@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 April 2003 09:58 pm, Andre Hedrick wrote:
> NO ATAPI DMA!
>
> I will not write the driver core to attempt to support the various
> combinations.  The ATAPI DMA engine space is used support 48bit.
> Use the onboard controller for ATAPI.
> Andre Hedrick
> LAD Storage Consulting Group

Can I object that it came built onto the board? okok... i'll take that 
as a no for now...

Tho i'm still not quite sure how it makes a diff to be honest, unless 
you mean that the Promise and HPT will never be supported for DMA?

and the only other thing i should say is that altho i'm not exactly a 
n00b, the average user WILL expect it to work.

can i expect this to be fixed by 2.6? (yeah, i know... 2.4-ac-ide code 
is similar to 2.5-ide code)
--
tabris
