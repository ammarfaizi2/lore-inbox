Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135216AbRD3NtP>; Mon, 30 Apr 2001 09:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135241AbRD3NtF>; Mon, 30 Apr 2001 09:49:05 -0400
Received: from dutidad.twi.tudelft.nl ([130.161.158.199]:20620 "EHLO dutidad")
	by vger.kernel.org with ESMTP id <S135216AbRD3Nsy>;
	Mon, 30 Apr 2001 09:48:54 -0400
Date: Mon, 30 Apr 2001 15:48:52 +0200
From: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
To: kiza@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: pci/quirks.c - VIA PCI latency in 2.4.4
Message-ID: <20010430154852.D8052@dutidad.twi.tudelft.nl>
Reply-To: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right, this is a problem, your solution is not entirely correct
though (the south bridge has to be checked, but the patch is to the config
registers of the pci-host bridge).  Please see my patch posted on this list
with subject "Re: 2.4.4 Sound corruption [PATCH] NEW, ignore previous
patch".

Regards,

-- 
charl p. botha      | computer graphics and cad/cam 
http://cpbotha.net/ | http://www.cg.its.tudelft.nl/
