Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312379AbSCUQkN>; Thu, 21 Mar 2002 11:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312384AbSCUQkD>; Thu, 21 Mar 2002 11:40:03 -0500
Received: from ns.suse.de ([213.95.15.193]:39696 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312379AbSCUQjy>;
	Thu, 21 Mar 2002 11:39:54 -0500
Date: Thu, 21 Mar 2002 17:39:53 +0100
From: Dave Jones <davej@suse.de>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 does not compile
Message-ID: <20020321173953.F22861@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C9A0735.8999EBB3@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 05:15:49PM +0100, Jean-Luc Coulon wrote:
 > -DKBUILD_BASENAME=scc  -c -o scc.o scc.c
 > scc.c: In function `scc_net_rx':
 > scc.c:1664: `dev' undeclared (first use in this function)

Line should read..

scc->dev->last_rx = jiffies;

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
