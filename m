Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263544AbUEYF5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUEYF5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 01:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUEYF5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 01:57:52 -0400
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:37012 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263544AbUEYF5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 01:57:51 -0400
Subject: 2.6.7rc1 vs 2.6.0
From: FabF <fabian.frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085464727.3762.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 May 2004 07:58:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Here's trivial fgrep vs report (using ffb1) :

2.6.7rc1 : 
Grepping  /usr/bin  :
45% cpu - 38.06 RT Sec - 1.10 Sec in KM
Entries scanned : 1527
85112 Kb analyzed this time

2.6.0 : 
Grepping  /usr/bin  :
51% cpu - 33.12 RT Sec - 1.10 Sec in KM
Entries scanned :1527
85112 Kb analyzed this time

	This is done against ext3 fs. Same .config, same box, same box state.
What relevance could explain this 5s delta ? IOW, what big ext3, mm new functionnalities have been plugged in-between ?

Thanks,
FabF

