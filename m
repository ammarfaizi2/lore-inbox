Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279901AbRKIOo6>; Fri, 9 Nov 2001 09:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279913AbRKIOoi>; Fri, 9 Nov 2001 09:44:38 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:25497
	"EHLO albatross-ext.wise.edt.ericsson.se") by vger.kernel.org
	with ESMTP id <S279901AbRKIOoa>; Fri, 9 Nov 2001 09:44:30 -0500
Message-ID: <3BEBEBDD.12B8B9FD@eed.ericsson.se>
Date: Fri, 09 Nov 2001 15:44:45 +0100
From: "Ronny Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>
Organization: Ericsson EuroLab
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14: crashing on heavy swap-load with SmartArray (cont.)
In-Reply-To: <3BEBD6E9.3F7F8057@eed.ericsson.se> <20011109143720.T4946@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

thanks a lot for your fast help. Unfortunately this will cause the
system to be TOTAL unresponsive and the disks to pause for 10secs
regularily not doing anything. No login possible or any interactive
work.
I saw no process being killed and it's runnig. A ps aux took 5 minutes
and still won't finish and kernel-time was 100% on both CPU. The only
thing it would bring back to life is SysRq-i (kill all tasks).
Are spinlocks the only possibility?
This really needs further investigation, it should really be able to
handle big loads from matlab-computations usually done by SUNs.

Regards,
Ronny
