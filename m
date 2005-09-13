Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVIMJn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVIMJn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVIMJn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:43:56 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:61162 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S932468AbVIMJn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:43:56 -0400
Date: Tue, 13 Sep 2005 11:43:51 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Problems with 2.6.13-rt5
Message-ID: <20050913094351.GX28883@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, 

Time is somehow more broken with -rt5 than with -rt4: 

europa:~# date --set="Tue Sep 13 10:57:00 CEST 2005"
Tue Sep 13 10:57:00 CEST 2005
europa:~# date
Thu Jan  1 01:03:49 CET 1970

Strange enough that KDE seems to have the time, although "date"
doesn't. Touching a file does also give it the "right" time. 

Running the hrttimers-support-dev tests shows several errors and
enabling preempt debugging features in the kernel config floods me with
preempt counts BUGs. 

Is there a known issue or should I try to reproduce the differences to
-rt4? 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

