Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbSLEXxI>; Thu, 5 Dec 2002 18:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbSLEXxI>; Thu, 5 Dec 2002 18:53:08 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:1222 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S267423AbSLEXxH>; Thu, 5 Dec 2002 18:53:07 -0500
Message-ID: <3DEFE86A.8060906@drugphish.ch>
Date: Fri, 06 Dec 2002 00:59:38 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil> <1039124530.18881.0.camel@rth.ninka.net> <20021205140349.A5998@ns1.theoesters.com> <3DEFD845.1000600@drugphish.ch> <20021205154822.A6762@ns1.theoesters.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[trimmed list drastically because I get a lot of bounce emails back]

> Eh?  Last I checked, there were other loadbalancing solutions out there.  Some
> even use hardware (like ours).  IOW - LVS isn't the only use for the hidden flag.

Oops, right. I forgot the HW LBs that do triangulation. I wonder 
however, why one wants to use a HW LB and not configure it to work in 
NAT mode.

> Granted, further discussion on the matter is an exercise in futility, as the current
> net maintainer has already stated his disdain for it.  So...we'll go on patching
> our kernels ad infinitum.

As mentioned before, you don't necessarily need to patch your kernels, 
there are other possibilities to overcome the arp problem. You could (if 
not already done so) consult the LVS howto where solutions are certainly 
applicable also to non-LVS LBs.

Regards and sorry for my wrong assumptions,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

