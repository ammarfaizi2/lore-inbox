Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261876AbTC1Bb3>; Thu, 27 Mar 2003 20:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261883AbTC1Bb2>; Thu, 27 Mar 2003 20:31:28 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:64384 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261876AbTC1Bb2>; Thu, 27 Mar 2003 20:31:28 -0500
Date: Fri, 28 Mar 2003 01:42:17 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Juan F. Camino" <camino@ucsd.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel2.4.21-pre5 with L1 L2 cache
Message-ID: <20030328014217.GA22072@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Juan F. Camino" <camino@ucsd.edu>, linux-kernel@vger.kernel.org
References: <20030326002432.GA14235@ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326002432.GA14235@ucsd.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 04:24:32PM -0800, Juan F. Camino wrote:

 > I have compiled kernel 2.4.20 (patch-2.4.21-pre5) but it does not
 > detect L1 and L2 Cache for my Celeron. Would that be a bug? Or am I missing
 > something on my configuration? I am quite sure Celeron has L2 =128k and
 > L1 = 8kb
 > dmesg 
 > CPU: Trace cache: 12K uops, L1 D cache: 8K

Your Celeron has a P4 core. The L1 icache is replaced with a tracecache.
As reported, you also have an 8KB L1 dcache.
The L2 isn't reported. Possibly its missing the ident that was added
to .21pre6

		Dave

