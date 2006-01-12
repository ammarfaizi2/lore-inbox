Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWALJUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWALJUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWALJUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:20:42 -0500
Received: from main.gmane.org ([80.91.229.2]:35279 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964982AbWALJUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:20:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Eric Belhomme <{gmane}+no/spam@ricospirit.net>
Subject: why sk98lin driver is not up-to date ?
Date: Thu, 12 Jan 2006 09:09:54 +0000 (UTC)
Message-ID: <Xns97496767C8536ericbelhommefreefr@80.91.229.5>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: paris.icsb.fr
User-Agent: Xnews/06.08.25
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was I trouble with my 3c940 gigabit NIC on my Debian Sid this latest 
kernel 2.6.15 self-compiled...
I wondered why ethtool was not able to get/set WoL status while the 
readme available on the sysKonnect website says sk98lin supports WoL :
http://www.syskonnect.com/syskonnect/support/driver/readme/linux/sk98lin.
html

So I looked at Documentation/networking/sk98lin.txt on my 2.6.15 tree :

sk98lin.txt created 13-Feb-2004
Readme File for sk98lin v6.23

And on drivers/net/sk98lin/h/skdrv1st.h :

 * Name:        skdrv1st.h
 * Project:     GEnesis, PCI Gigabit Ethernet Adapter
 * Version:     $Revision: 1.4 $
 * Date:        $Date: 2003/11/12 14:28:14 $
 * Purpose:     First header file for driver and all other modules

But on the syskonnect website, I downloaded a really more recent revision 
(Version: 8.28.1.3, Date: 29:09:2005) at this url :
http://www.skd.de/e_en/support/driver_searchresults.html?navid=13
&action=search&configurationId=e_en.downloads_support&term=typ.treiber+Li
nux+SK-9521&searchTerm=&produkt=SK-9521&typ=typ.treiber&system=Linux

A look on drivers/net/sk98lin/h/skdrv1st.h from this archive :

 * Name:	skdrv1st.h
 * Project:	GEnesis, PCI Gigabit Ethernet Adapter
 * Version:	$Revision: 1.5.2.6 $
 * Date:	$Date: 2005/08/09 07:14:29 $
 * Purpose:	First header file for driver and all other modules 


So this archive is more recent than sources included in stock kernel, but 
older than 2.6.14 kernel, so I wonder why this revision of sk98lin is not 
included in kernel ?
I firstly thinked about some GNU license violation, but header files 
still refer to GNU license... So what's the matter with this driver ?

Thanks for your attention,

-- 
Rico

