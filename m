Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293024AbSB1VEE>; Thu, 28 Feb 2002 16:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293748AbSB1VCW>; Thu, 28 Feb 2002 16:02:22 -0500
Received: from ns.suse.de ([213.95.15.193]:43794 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310112AbSB1VCA>;
	Thu, 28 Feb 2002 16:02:00 -0500
Date: Thu, 28 Feb 2002 22:01:58 +0100
From: Dave Jones <davej@suse.de>
To: Steven Cole <elenstev@mesatop.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-dj2, modify arch/i386/Config.help for highpte options.
Message-ID: <20020228220158.I32662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Steven Cole <elenstev@mesatop.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202281827.LAA26782@tstac.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202281827.LAA26782@tstac.esa.lanl.gov>; from elenstev@mesatop.com on Thu, Feb 28, 2002 at 12:12:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 12:12:51PM -0700, Steven Cole wrote:
 > Here is a snippet from arch/i386/config.in both 2.5.5-dj2 and 2.5.6-pre1:
 > choice 'High Memory Support' \
 >         "off           CONFIG_NOHIGHMEM \
 >          4GB           CONFIG_HIGHMEM4G \
 >          4GB-highpte   CONFIG_HIGHMEM4G_HIGHPTE \
 >          64GB          CONFIG_HIGHMEM64G \
 >          64GB-highpte  CONFIG_HIGHMEM64G_HIGHPTE" off

 Would this not be better done using a "use highpte" bool in
 the !CONFIG_NOHIGHMEM case ? 
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
