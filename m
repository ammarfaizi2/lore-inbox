Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSE3Xtg>; Thu, 30 May 2002 19:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSE3Xtf>; Thu, 30 May 2002 19:49:35 -0400
Received: from ns.suse.de ([213.95.15.193]:56842 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S293203AbSE3Xtf>;
	Thu, 30 May 2002 19:49:35 -0400
Date: Fri, 31 May 2002 01:49:35 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre9-ac3
Message-ID: <20020531014935.D9282@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200205302322.g4UNMne06371@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 07:22:49PM -0400, Alan Cox wrote:
 > [+ indicates stuff that went to Marcelo, o stuff that has not,
 >  * indicates stuff that is merged in mainstream now, X stuff that proved
 >    bad and was dropped out]
 > 
 > Linux 2.4.19pre9-ac3
 > o	Cpufreq updates			(Dominik Brodowski, Dave Jones0
 > 	| Now includes some reverse engineered speedstep support 

Two points worth mentioning in regard to this.
1. The first type of speedstep (found in systems with BX chipsets)
   isn't supported. Only the later type found in systems with ICH
   chipsets will work with this driver..
2. Dominik did 99.9% of the Spudstop work, so all offers of free moneyi
   should be directed to him.

    davej0.  :-P

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
