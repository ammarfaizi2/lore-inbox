Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUG2Fes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUG2Fes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 01:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUG2Fes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 01:34:48 -0400
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:18089 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264256AbUG2Fer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 01:34:47 -0400
Subject: symlinks follow 8 or 5?
From: FabF <fabian.frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091079278.1999.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 07:34:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	do_follow_link comments is "This limits recursive symlink follows to 8"
... but having (x=1->10) ln -s x+1 x and trying cat 1 just works for x <
7 which drops follow mode to 5.Is this irrelevant ?

Regards,
FabF
  

