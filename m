Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273691AbRJIIeK>; Tue, 9 Oct 2001 04:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273724AbRJIIeA>; Tue, 9 Oct 2001 04:34:00 -0400
Received: from smtp2.nikoma.de ([212.122.128.25]:11534 "EHLO smtp2.nikoma.de")
	by vger.kernel.org with ESMTP id <S273691AbRJIIdr>;
	Tue, 9 Oct 2001 04:33:47 -0400
Date: Tue, 9 Oct 2001 10:33:59 +0200
From: Thomas Roessler <roessler@does-not-exist.org>
To: linux-kernel@vger.kernel.org
Subject: [2.4.10] /proc freeze during core dump?
Message-ID: <20011009103359.F2935@sobolev.does-not-exist.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Thomas Roessler <roessler@does-not-exist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Face: Oxq^+Q$NuUQ-&J#F14uCyP4}v%$5{ZGnS}PX;zoxOQ%*`#dkJ'qx$w}\Z;m.e*,_K0V8mii$qU(|l
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday, I was able to observe my machine running 2.4.10 
half-crash while mozilla tried to dump core: Six minutes after 
core.<pid> had been created for the process in question, any process 
trying to read /proc/<pid>/stat (which still existed then; note that 
there was no disk activity at that point) would hang, and was 
apparently unkillable.

There was no ooops or kernel panic in the logs.

-- 
Thomas Roessler                        http://log.does-not-exist.org/
