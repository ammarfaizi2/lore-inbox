Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUJPIBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUJPIBn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 04:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268680AbUJPIBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 04:01:43 -0400
Received: from adsl-65-68-135-106.dsl.stlsmo.swbell.net ([65.68.135.106]:15776
	"EHLO ramius.hardwarefreak.com") by vger.kernel.org with ESMTP
	id S268677AbUJPIBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 04:01:41 -0400
Message-ID: <65717CC11CAED4118C1100A02401ECAA072C7F@RAMIUS>
From: Stan Hoeppner <stan@hardwarefreak.com>
To: "'Paul Jackson'" <pj@sgi.com>, ebiederm@xmission.com
Cc: mbligh@aracnet.com, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: RE: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placemen
	t
Date: Sat, 16 Oct 2004 03:01:32 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Kevin McMahon <n6965@sgi.com> pointed out to me a link to an 
> interesting
> article on gang scheduling:
> 
>   http://www.linuxjournal.com/article.php?sid=7690
>   Issue 127: Improving Application Performance on HPC Systems 
> with Process Synchronization
>   Posted on Monday, November 01, 2004 by Paul Terry Amar Shan 
> Pentti Huttunen
> 
> It's amazingly current - won't even be posted for another 
> couple of weeks ;).


It appears they are using their Rapid Array ASICs/network for the time
synchronization.  I wonder if it would be possible to implement this
solution on standard cluster hardware that doesn't have this custom network
with its inherent fine grained clock.  NTP wouldn't be able to give
microsecond level time synchronization would it, considering its daemon
status...

This would definitely be a feather in the cap for someone who could code
this to work with SHV (standard high volume) hardware.

Stan Hoeppner
TheHardwareFreak
stan@hardwarefreak.com
