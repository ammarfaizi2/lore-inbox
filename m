Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269906AbTGKLcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 07:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269910AbTGKLcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 07:32:21 -0400
Received: from hermes.ex.ac.uk ([144.173.6.14]:29099 "EHLO hermes.ex.ac.uk")
	by vger.kernel.org with ESMTP id S269906AbTGKLb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 07:31:57 -0400
Subject: 2.4.21 - minor config glitch
From: Alan Brady <Alan.C.Brady@exeter.ac.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1057924063.32461.61.camel@tactile.ex.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jul 2003 12:47:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not a bug, but some apps choke when trying to parse the missing
condition. 


/usr/src/linux-2.4.21//drivers/char/Config.in, line 161:

	if [ "$CONFIG_PPC64" ] ; then 
                   ^^^

I presume this should get set as
 
	if [ "$CONFIG_PPC64" = "y" ] ; then

Alan

-- 
Alan Brady <Alan.C.Brady@ex.ac.uk>

