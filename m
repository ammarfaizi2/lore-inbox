Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbUADOgC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbUADOgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:36:02 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:14343 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265609AbUADOgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:36:00 -0500
Date: Sun, 4 Jan 2004 15:35:55 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Cristiano De Michele <demichel@na.infn.it>
Cc: linux kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 oops
Message-ID: <20040104143555.GF3728@alpha.home.local>
References: <1073223226.1695.10.camel@cripat.acasa-tr.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073223226.1695.10.camel@cripat.acasa-tr.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Sun, Jan 04, 2004 at 02:33:46PM +0100, Cristiano De Michele wrote:

> Jan  3 04:39:42 cripat kernel: EFLAGS: 00010016
> Jan  3 04:39:42 cripat kernel: eax: 616d7157   ebx: 6d6e6f72   ecx:
> c8a5c000   edx: 73694400

This is weird, eax, ebx and edx contain portions of text :
  eax="Wqma"
  ebx="ronm"
  edx="siD\0"

Perhaps it's pure coincidence, but it may also be a part of a URL or
temporary file name. Could you run memtest86 on you system to check
that you don't have RAM defects ?

Willy

