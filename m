Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262550AbREVDBD>; Mon, 21 May 2001 23:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262551AbREVDAx>; Mon, 21 May 2001 23:00:53 -0400
Received: from [209.250.53.92] ([209.250.53.92]:8968 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S262550AbREVDAm>; Mon, 21 May 2001 23:00:42 -0400
Date: Mon, 21 May 2001 21:59:27 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
Message-ID: <20010521215927.B31289@hapablap.dyn.dhs.org>
In-Reply-To: <3B090C81.53F163C3@TeraPort.de> <9ebbg2$m62$1@tazenda.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9ebbg2$m62$1@tazenda.transmeta.com>; from hpa@transmeta.com on Mon, May 21, 2001 at 08:16:18AM -0700
X-Uptime: 7:36pm  up 1 day,  3:31,  1 user,  load average: 1.30, 1.21, 1.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 08:16:18AM -0700, H. Peter Anvin wrote:
> Followup to:  <3B090C81.53F163C3@TeraPort.de>
> By author:    "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
> In newsgroup: linux.dev.kernel
> >
> > Hi,
> > 
> >  while trying to enhance a small hardware inventory script, I found that
> > cpuinfo is missing the details of L1, L2 and L3 size, although they may
> > be available at boot time. One could of cource grep them from "dmesg"
> > output, but that may scroll away on long lived systems.
> > 
> 
> Any particular reason this needs to be done in the kernel, as opposed
> to having your script read /dev/cpu/*/cpuid?

Wouldn't that be the same reason we have /anything/ in cpuinfo?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
