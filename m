Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbUCESi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUCESi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:38:58 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:55427 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262672AbUCESi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:38:58 -0500
Date: Fri, 5 Mar 2004 18:37:06 +0000
From: Dave Jones <davej@redhat.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] v2.6.3 moduleparam-patches
Message-ID: <20040305183706.GA26176@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040305174904.O30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305174904.O30061@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 05:49:04PM +0100, Wim Van Sebroeck wrote:
 > Hi Linus, Andrew,
 > 
 > please do a
 > 
 > 	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

btw, it'd be nice to have CONFIG_WDT_501_FAN tuned into a module
param instead of a compile time decision too. The "only turn this
on if you have the fan tachometer set up" clause means that for
example vendor kernels can't enable this.

		Dave

