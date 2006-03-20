Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWCTSpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWCTSpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWCTSpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:45:35 -0500
Received: from main.gmane.org ([80.91.229.2]:42654 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751255AbWCTSpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:45:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: Libata PATA for 2.6.16
Date: Mon, 20 Mar 2006 19:44:03 +0100
Message-ID: <pan.2006.03.20.18.44.01.910970@free.fr>
References: <1142869095.20050.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Le Mon, 20 Mar 2006 15:38:15 +0000, Alan Cox a écrit :

> Can be found at the usual location
> 
> 	http://zeniv.linux.org.uk/~alan/IDE
> 
> Some further small changes and updates, in particular the use of
> platform device class for VLB/ISA/legacy IDE ports and the removal of
> the "no device" special cases from the core.
> 
I still got the same problems on via :
 - hardisk used at UDMA33 instead of UDMA100 (buggy cable select ??? for
the primary CS value was 0xf1f1e6e6 and for the secondary 0x2727e6e6)
 - a cdrw drive lost interrupt when setting xfermode and make failed a
 port initialisation (if I comment the disable code, everythings seems to
 work)

Matthieu

