Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUIJUbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUIJUbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 16:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUIJUbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 16:31:19 -0400
Received: from gate.in-addr.de ([212.8.193.158]:42951 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S267765AbUIJUbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 16:31:17 -0400
Date: Fri, 10 Sep 2004 19:51:29 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: sdake@mvista.com,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       Daniel Phillips <phillips@redhat.com>
Cc: openais@lists.osdl.org, linux-ha-dev@lists.linux-ha.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] New virtual synchrony API for the kernel: was Re: [Openais] New API in openais
Message-ID: <20040910175129.GT7359@marowsky-bree.de>
References: <1093941076.3613.14.camel@persist.az.mvista.com> <1093973757.5933.56.camel@cherrybomb.pdx.osdl.net> <1093981842.3613.42.camel@persist.az.mvista.com> <200409011115.45780.phillips@redhat.com> <1094104992.5515.47.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1094104992.5515.47.camel@persist.az.mvista.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-09-01T23:03:12,
   Steven Dake <sdake@mvista.com> said:

I've been pretty busy the last couple of days, so please bear with me
for my late reply.

A virtual synchrony group messaging component would certainly be
immensely helpful. As it pretty strongly ties to membership events (as
you very correctly point out), I do think we need to review the APIs
here.

Could you post some sample code and how / where you'd propose to merge
it in?

Also, again, I'm not sure this needs to be in the kernel. Do you have
upper bounds of the memory consumption? Would the speed really benefit
from being in the kernel?

OTOH, all other networking protocols such as TCP, SCTP or even IP/Sec
live in kernel space, so clearly there's prior evidence of this being a
reasonable idea.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	   \\\  /// 
SUSE Labs, Research and Development \honk/ 
SUSE LINUX AG - A Novell company     \\// 

