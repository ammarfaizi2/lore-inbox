Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311756AbSCNU0M>; Thu, 14 Mar 2002 15:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311757AbSCNUZw>; Thu, 14 Mar 2002 15:25:52 -0500
Received: from ns.suse.de ([213.95.15.193]:36625 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311756AbSCNUZn>;
	Thu, 14 Mar 2002 15:25:43 -0500
Date: Thu, 14 Mar 2002 21:25:40 +0100
From: Dave Jones <davej@suse.de>
To: M Sweger <mikesw@ns1.whiterose.net>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: linux 2.2.21 pre3, pre4 and rc1 problems. (fwd)
Message-ID: <20020314212540.A25217@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	M Sweger <mikesw@ns1.whiterose.net>, linux-kernel@vger.kernel.org,
	alan@redhat.com
In-Reply-To: <Pine.BSF.4.21.0203141518590.18036-100000@ns1.whiterose.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSF.4.21.0203141518590.18036-100000@ns1.whiterose.net>; from mikesw@ns1.whiterose.net on Thu, Mar 14, 2002 at 03:19:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 03:19:56PM -0500, M Sweger wrote:
 > v2.2.21rc1       Oops' on boot after the message "CPU: L2 cache = 512K
 >                  with a kernel panic. Note: I don't have any swap turned on.
 > >>EIP; c0297244 <init_intel+33c/34c>   <=====

 Fix posted to the list earlier. Add =NULL to the declaration
 of the variable p in arch/i386/kernel/setup.c:init_intel()

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
