Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbUFFMgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUFFMgT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUFFMgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:36:19 -0400
Received: from holomorphy.com ([207.189.100.168]:46001 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263435AbUFFMgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:36:18 -0400
Date: Sun, 6 Jun 2004 05:36:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: rusty@rustcorp.com.au, mikpe@csd.uu.se, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040606123611.GU21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, rusty@rustcorp.com.au, mikpe@csd.uu.se,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040604112744.GZ21007@holomorphy.com> <20040604113252.GA21007@holomorphy.com> <20040604092316.3ab91e36.pj@sgi.com> <20040604162853.GB21007@holomorphy.com> <20040604104756.472fd542.pj@sgi.com> <20040604181233.GF21007@holomorphy.com> <1086487651.11454.19.camel@bach> <20040606051657.3c9b44d3.pj@sgi.com> <20040606121327.GT21007@holomorphy.com> <20040606052843.5bbe16f3.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606052843.5bbe16f3.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, my attribution was unkindly stripped from:
>> You've been told, and several times already. The current example is
>> userspace needing to know when to stop trying to online cpus.

On Sun, Jun 06, 2004 at 05:28:43AM -0700, Paul Jackson wrote:
> To which I've answered, you are describing cpu_possible_map,
> cpu_present_map and cpu_online_map, not NR_CPUS.

Why do I have to put up with this and why do they always come after me?
All of their sizes are rounded up to CHAR_BIT*sizeof(cpumask_t), and
all of their contents are variable.

Hmm. /proc/config.gz will do for now.


-- wli
