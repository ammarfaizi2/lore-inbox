Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313434AbSC2LeH>; Fri, 29 Mar 2002 06:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313435AbSC2Ld5>; Fri, 29 Mar 2002 06:33:57 -0500
Received: from h00403399c977.ne.client2.attbi.com ([24.218.248.214]:21943 "EHLO
	fred.cambridge.ma.us") by vger.kernel.org with ESMTP
	id <S313434AbSC2Ldx>; Fri, 29 Mar 2002 06:33:53 -0500
From: pjd@fred001.dynip.com
Message-Id: <200203291133.g2TBXsi10506@fred.cambridge.ma.us>
Subject: Re: Networking with slow CPUs
To: robert@schwebel.de
Date: Fri, 29 Mar 2002 06:33:54 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.33.0203271944020.16178-100000@callisto.local> from "Robert Schwebel" at Mar 27, 2002 07:46:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> 
> Is there a possibility to "harden" a small machine (33 MHz embedded
> device) against e.g. flood pings from the outside world?

It *is* bleeding edge, as someone else pointed out, but you should 
really investigate NAPI.  It's designed to make Linux resiliant against
non-flow-controlled network loads like routing, which sounds like 
just the ticket.
 --
 Peter Desnoyers 
