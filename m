Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292631AbSB0QVL>; Wed, 27 Feb 2002 11:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292776AbSB0QUt>; Wed, 27 Feb 2002 11:20:49 -0500
Received: from ns.suse.de ([213.95.15.193]:53010 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292690AbSB0QUc>;
	Wed, 27 Feb 2002 11:20:32 -0500
Date: Wed, 27 Feb 2002 17:20:30 +0100
From: Dave Jones <davej@suse.de>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2 oops
Message-ID: <20020227172030.F16565@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Ben Clifford <benc@hawaga.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226223406.A26905@suse.de> <Pine.LNX.4.33.0202270746090.2059-100000@barbarella.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202270746090.2059-100000@barbarella.hawaga.org.uk>; from benc@hawaga.org.uk on Wed, Feb 27, 2002 at 08:13:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 08:13:49AM -0800, Ben Clifford wrote:
 > >>EIP; c01883c4 <vc_allocate+e4/f0>   <=====
 > Trace; c0189059 <con_open+19/70>
 > Trace; c017f726 <tty_open+216/3c0>

 Yup, something not quite right with the last set of James' console
 changes by the looks. I already bounced him a copy of a similar oops.

 For now, you could try backing out the console-preempt.diff patch
 from http://www.codemonkey.org.uk/patches/merged/2.5.5/dj2/

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
