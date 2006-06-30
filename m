Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbWF3RIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWF3RIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWF3RIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:08:10 -0400
Received: from ns.suse.de ([195.135.220.2]:39298 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751807AbWF3RIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:08:09 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Date: Fri, 30 Jun 2006 19:08:03 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <200606301633.35818.ak@suse.de> <20060630160203.GH22381@frankl.hpl.hp.com>
In-Reply-To: <20060630160203.GH22381@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301908.03934.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 June 2006 18:02, Stephane Eranian wrote:
> Andi,
> 
> As a first step, I am looking at implementing a TIF_DEBUG
> for x86-64. AFAIK, debug registers must not be inherited on
> fork().

Why not?  Especially for threads you probably want them
in the new thread too.

-Andi
