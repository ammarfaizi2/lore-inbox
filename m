Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290550AbSBFOHD>; Wed, 6 Feb 2002 09:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290551AbSBFOGx>; Wed, 6 Feb 2002 09:06:53 -0500
Received: from ns.suse.de ([213.95.15.193]:4363 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290550AbSBFOGt>;
	Wed, 6 Feb 2002 09:06:49 -0500
Date: Wed, 6 Feb 2002 15:06:45 +0100
From: Dave Jones <davej@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
Message-ID: <20020206150645.G7337@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andi Kleen <ak@suse.de>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <5.1.0.14.2.20011207092244.049f6720@pop.cus.cam.ac.uk.suse.lists.linux.kernel> <200202061258.g16CwGt31197@Port.imtp.ilyichevsk.odessa.ua.suse.lists.linux.kernel> <p73ofj2lpdg.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p73ofj2lpdg.fsf@oldwotan.suse.de>; from ak@suse.de on Wed, Feb 06, 2002 at 02:19:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 02:19:07PM +0100, Andi Kleen wrote:

 > glibc 2.3 seems to plan to use segment register based thread local data for 
 > even non threaded programs, so it would be a good idea to optimize LDT 
 > allocation a bit (= not allocate 64K of vmalloc space every time 
 > sys_modify_ldt is called - there is only 8MB of it) 

 Manfred Spraul had a patch that did this.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
