Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268766AbUIQN5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268766AbUIQN5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268769AbUIQN5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:57:41 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:38885 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S268766AbUIQNzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:55:43 -0400
Date: Fri, 17 Sep 2004 06:55:35 -0700
From: Larry McVoy <lm@bitmover.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Message-ID: <20040917135534.GA13299@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409171421.15470.vda@port.imtp.ilyichevsk.odessa.ua> <20040917121040.GN9106@holomorphy.com> <200409171604.39622.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171604.39622.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there an easy way to run only this one? I can profile that.
> Larry? 

Absolutely, when you are in the source directory you can see how all this
is run, it's just a shell script.  Look in ../scripts/lmbench for lat_pipe
and run that.

In general, the code in LMbench is very very small and it's easy to tinker
with the system and add more tests.  I've been very surprised over the 
years that people haven't done so.

For what it is worth, we're looking at porting LMbench to Windows using 
the Unix API layer we did in BitKeeper.  
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
