Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274893AbTGaVyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270634AbTGaVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:54:00 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:64458 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S274921AbTGaVx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:53:57 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: HELP: cpufreq on HT and/or SMP systems
Date: Thu, 31 Jul 2003 23:53:54 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307312353.54735.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some doubts regarding cpufreq for SMP systems (for developing 
http://mnm.uib.es/~gallir/cpudyn/).

If I remember well, I read a while ago that cpufreq didn't work in SMP 
systems, but reading the docs and kernel/cpufreq.c, it seems there should be 
any problem? 

Is it true?

OTH, I trying it on a P4 HT, and it works, changes in the frequency of one of 
the "cpu's",  changes both. 

What happens in the case of several real cpu's? Does it keep the same 
frequency for every cpu? According to a comment in cpufreq.c, it seems that 
each cpu might have different frequencies.

So, what's recommended? Change the frequency of every cpu one by one?

Thanks,

PS: sorry, I don't have any cpufreq/SMP machine at hand.


-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/
