Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSE3Pfl>; Thu, 30 May 2002 11:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316752AbSE3Pfk>; Thu, 30 May 2002 11:35:40 -0400
Received: from ns.suse.de ([213.95.15.193]:49672 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316751AbSE3Pfi>;
	Thu, 30 May 2002 11:35:38 -0400
Date: Thu, 30 May 2002 17:35:39 +0200
From: Dave Jones <davej@suse.de>
To: =?iso-8859-1?Q?Bj=F6rn_Antonsson?= <d93-ban@nada.kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How do you detect that hyperthreading is activated?
Message-ID: <20020530173539.Q26821@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	=?iso-8859-1?Q?Bj=F6rn_Antonsson?= <d93-ban@nada.kth.se>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205301529.RAA09965@knatte.nada.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 05:29:40PM +0200, Björn Antonsson wrote:
 > Is there a way that I can get at the logical/physical CPU bits, as
 > reported by the CPUID instruction, of all available CPUs? Or is there
 > an even better way?

/dev/cpu/*/cpuid

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
