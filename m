Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274369AbRITI0T>; Thu, 20 Sep 2001 04:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274370AbRITI0J>; Thu, 20 Sep 2001 04:26:09 -0400
Received: from gatekeeper-s.gts.cz ([194.213.203.154]:36334 "HELO
	mail.idoox.com") by vger.kernel.org with SMTP id <S274369AbRITIZx>;
	Thu, 20 Sep 2001 04:25:53 -0400
Date: Thu, 20 Sep 2001 10:26:16 +0200
From: David Hajek <david@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: high cpu load with sw raid1
Message-ID: <20010920102616.A2753@pida.ulita.cz>
Reply-To: david@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.19
Organization: IDOOX.COM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have linux box with 70GB SW Raid1. This box runs for half
a year without problems but now I meet the high cpu load 
problems. I suspect that it can be caused by not enough 
free disk space on this md device. I see following:

1 GB free  - load > 5
5 GB free  - load < 1

I have to notice that this box is rather under heavy load
(1 GB cvs tree, nfs homes etc.) My question is whether this 
load can depend on available disk space because I do not
see any suspect processes that can cause such a high load.

Kernel: 2.2.19
Patches: lfs + md + ide
RH6.2 + glibc-2.2.12

Thanks.

--
David Hajek
hajek@idoox.com 
- Heisenberg may have slept here...

