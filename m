Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268058AbTAJAOL>; Thu, 9 Jan 2003 19:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268070AbTAJAOL>; Thu, 9 Jan 2003 19:14:11 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31981 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268058AbTAJAOK>;
	Thu, 9 Jan 2003 19:14:10 -0500
Date: Fri, 10 Jan 2003 00:20:17 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jason Lunz <lunz@falooley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: detecting hyperthreading in linux 2.4.19
Message-ID: <20030110002016.GB8319@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jason Lunz <lunz@falooley.org>, linux-kernel@vger.kernel.org
References: <slrnb1rlct.g2c.lunz@stoli.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnb1rlct.g2c.lunz@stoli.localnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 08:02:33PM +0000, Jason Lunz wrote:
 > Is there a way for a userspace program running on linux 2.4.19 to tell
 > the difference between a single hyperthreaded xeon P4 with HT enabled
 > and a dual hyperthreaded xeon P4 with HT disabled? The /proc/cpuinfos
 > for the two cases are indistinguishable.

Check out x86info[1]. It should do the right thing in both cases.
It counts siblings, and also checks the BIOS MP table.

		Dave

[1] http://www.codemonkey.org.uk/x86info/
		
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
