Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbTJIIIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 04:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTJIIIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 04:08:07 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:28459 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261920AbTJIIIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 04:08:06 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: 2.7 thoughts
Date: Thu, 9 Oct 2003 10:08:00 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Some thoughts for 2.7.Someone has other ideas, comments ?
	
*	slab allocation limit
*	complete user quota centralization 
*	Add _responsibilities_ for virtual process tree and possible
relation in oops cases 
*	Does the whole proc vm stuff root/box relevant ?I don't think
so....Hence, those proc entries deserve security relevant attributes 
*	Devices should be limited as well against bad usage(floppy defect),
viral activity(netcard rush)... 
*	All this guides me to a more global conclusion in which all that
stuff should be kobject registration relevant 
*	Meanwhile, we don't have a kobject <-> security bridge :( 

Regards,
Fabian
