Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSEWOJK>; Thu, 23 May 2002 10:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316720AbSEWOJJ>; Thu, 23 May 2002 10:09:09 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52238 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S316712AbSEWOJJ>; Thu, 23 May 2002 10:09:09 -0400
Date: Thu, 23 May 2002 16:09:04 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre8-ac5 observations
Message-ID: <20020523140904.GA3435@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I faintly recall reading about "invalidate: busy buffer" or "invalidate:
dirty buffer" fixes in recent 2.4.19-pre-/ac kernels. However, during
vgscan, I still get lots of these.

Also, for a 3C900 Combo card, I get this:

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xd000. Vers LK1.1.17
 ***WARNING*** No MII transceivers found!

Being a 10 Mbps card with BNC and AUI interfaces, it does not really
need an MII, so I don't quite get the meaning of the warning. It might
be disabled.

-- 
Matthias Andree
