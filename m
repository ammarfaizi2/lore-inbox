Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbSLOADm>; Sat, 14 Dec 2002 19:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbSLOADm>; Sat, 14 Dec 2002 19:03:42 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:30349 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266091AbSLOADm>;
	Sat, 14 Dec 2002 19:03:42 -0500
Date: Sun, 15 Dec 2002 00:11:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Sapan Bhatia <bhatia@enseirb.fr>
Cc: linux-kernel@vger.kernel.org, reveillere@enseirb.fr
Subject: Re: MCE 7 / Athlon / 2.4.20
Message-ID: <20021215001107.GA8053@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Sapan Bhatia <bhatia@enseirb.fr>, linux-kernel@vger.kernel.org,
	reveillere@enseirb.fr
References: <20021214222816.A487@enseirb.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021214222816.A487@enseirb.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 10:28:16PM +0100, Sapan Bhatia wrote:
 > Hi,
 > 
 > I'm using a Compaq Evo N1005v: Athlon 1.5GHz/256MB RAM.
 > I get the following MCE when trying to boot 2.4.20, followed by a kernel
 > panic:
 > 
 > MCE 7
 > Bank: 3
 > Code: b40000000000083b 
 > Addr: 00000001fc0003b3

Ahh, I have the 1015v and I bet it has the same problem.
There are bits of isa space we probe that cause machine checks.
Fixed in 2.4.20-ac, and 2.4.21pre/bitkeeper.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
