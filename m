Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285233AbRLMWpF>; Thu, 13 Dec 2001 17:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285241AbRLMWor>; Thu, 13 Dec 2001 17:44:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26118 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285233AbRLMWoa>; Thu, 13 Dec 2001 17:44:30 -0500
Date: Thu, 13 Dec 2001 22:44:00 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
Cc: linux-kernel@vger.kernel.org, large-discuss@lists.sourceforge.net,
        Heiko Carstens <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        Anton Blanchard <antonb@au1.ibm.com>,
        Greg Kroah-Hartman <ghartman@us.ibm.com>, rusty@rustcorp.com.au
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.5.0
Message-ID: <20011213224400.H8007@flint.arm.linux.org.uk>
In-Reply-To: <20011213132557.5B3E.K-SUGANUMA@mvj.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213132557.5B3E.K-SUGANUMA@mvj.biglobe.ne.jp>; from k-suganuma@mvj.biglobe.ne.jp on Thu, Dec 13, 2001 at 01:29:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 01:29:42PM -0800, Kimio Suganuma wrote:
> Down CPU
> echo 0 > /proc/sys/kernel/cpu/<id>/online
> 
> Up CPU
> echo 1 > /proc/sys/kernel/cpu/<id>/online

Please use /proc/sys/cpu/*/ so that we have all CPU information in
a consistent place.  Please see linux/include/linux/sysctl.h for the
sysctl allocation.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

