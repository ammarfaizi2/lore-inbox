Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVAMLGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVAMLGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVAMLEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:04:52 -0500
Received: from static-162-83-93-166.fred.east.verizon.net ([162.83.93.166]:6302
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S261593AbVAMLAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 06:00:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16870.21720.866418.326325@ccs.covici.com>
Date: Thu, 13 Jan 2005 06:00:40 -0500
From: John covici <covici@ccs.covici.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
In-Reply-To: <41E64DAB.1010808@hist.no>
References: <41E64DAB.1010808@hist.no>
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting something similar -- the X process gets stuck in some
kind of system call, but I can login from the network and shut the
system down, but I cannot change the console from the X to a text
console.

on Thursday 01/13/2005 Helge Hafting(helge.hafting@hist.no) wrote
 > 2.6.10 boots fine, but is killed by the X server when it
 > tries to initialize my PCI radeon 9200 SE.  This problem exists
 > in 2.6.9 too, but not in 2.6.8.1.  So I'm stuck with that version currently.
 > 
 > The problem seems to be access to the card bios, X uses
 > int10 bios calls to initialize the card.
 > 
 > Helge Hafting
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/

-- 
         John Covici
         covici@ccs.covici.com
