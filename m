Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293386AbSCVIfJ>; Fri, 22 Mar 2002 03:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293448AbSCVIe7>; Fri, 22 Mar 2002 03:34:59 -0500
Received: from ns.suse.de ([213.95.15.193]:56324 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293386AbSCVIek>;
	Fri, 22 Mar 2002 03:34:40 -0500
Date: Fri, 22 Mar 2002 09:34:39 +0100
From: Dave Jones <davej@suse.de>
To: dd8ne@bnv-bamberg.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 does not compile
Message-ID: <20020322093439.S22861@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, dd8ne@bnv-bamberg.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C9A0735.8999EBB3@wanadoo.fr> <20020321173953.F22861@suse.de> <20020322.6534800@dd8ne.ofr.de.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 06:53:48AM +0000, Hans-Joachim Hetscher wrote:
 > It seeems to be the same bug in 6pack.c
 > So, I solved the problem in line 259 of 6pack.c by changing
 > dev->last_rx = jiffies;
 > into 
 > sp->dev->last_rx = jiffies; 

Yeah, it's a mystery how these broken versions of the fixes ended up
in Jeff's tree.  He took them from my tree, and my tree already has this
and the previous corrected fix. really weird.

anyways, it's moot as all this is going to Jeff at the end of the week
anyway for his pushing to Linus on his return the following week 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
