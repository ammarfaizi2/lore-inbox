Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132651AbRDONUW>; Sun, 15 Apr 2001 09:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132655AbRDONUN>; Sun, 15 Apr 2001 09:20:13 -0400
Received: from [203.36.158.121] ([203.36.158.121]:58759 "EHLO
	piro.kabuki.openfridge.net") by vger.kernel.org with ESMTP
	id <S132651AbRDONUJ>; Sun, 15 Apr 2001 09:20:09 -0400
Date: Sun, 15 Apr 2001 23:20:01 +1000
From: Daniel Stone <daniel@kabuki.openfridge.net>
To: linux-kernel@vger.kernel.org
Subject: Re: comments on CML 1.1.0
Message-ID: <20010415232001.A9242@piro.kabuki.openfridge.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200104140317.f3E3Hv805992@snark.thyrsus.com> <20010414150421.A28066@l-t.ee> <002601c0c4fb$c7e54260$0201a8c0@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <002601c0c4fb$c7e54260$0201a8c0@home>; from jeff@wa1hco.mv.com on Sat, Apr 14, 2001 at 11:58:41AM -0400
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2001 at 11:58:41AM -0400, jeff millar wrote:
> Selecting IP_NF_COMPAT_IPCHAINS turns off IP_NF_CONNTRACK and friends.  But,
> I think CML1, allowed both support to the new iptables and compatibility
> modes to allow old ipchains scripts to work with the new kernel.

Only as modules: conntrack/queueing/iptables, ipchains compat, and ipfwadm
compat, are all mutually exclusive. The only way that this was at all
possible in 2.4.x was via modules, but even then, they were still mutually
exclusive.

-- 
Daniel Stone
Linux Kernel Developer
daniel@kabuki.openfridge.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------
