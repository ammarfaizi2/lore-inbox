Return-Path: <linux-kernel-owner+w=401wt.eu-S965156AbWL2UpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWL2UpM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWL2UpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:45:11 -0500
Received: from main.gmane.org ([80.91.229.2]:55400 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965156AbWL2UpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:45:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ritesh Raj Sarraf <rrs@researchut.com>
Subject: select() to /dev/rtc to wait for clock tick timed out
Date: Sat, 30 Dec 2006 01:11:25 +0530
Organization: RESEARCHUT
Message-ID: <6k7g64-ln8.ln1@www.researchut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203.187.253.248
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Dell XPS M1210 notebook with 2.6.18 running on it.

I've noticed that a recent BIOS upgrade (A03 -> A05) has started giving me this
message on system boot when hwclock runs.

select() to /dev/rtc to wait for clock tick timed out

My machine has a dual-core Intel processor.

A quick search revealed a workaround for hwclock to use the --directisa option.
Also this bug seems to be generic to dual-core Intel processors as many other
people also are facing the same issue on servers/desktops/laptops.

Thanks,
Ritesh
-- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
"Stealing logic from one person is plagiarism, stealing from many is research."
"The great are those who achieve the impossible, the petty are those who
cannot - rrs"

