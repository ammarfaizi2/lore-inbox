Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbUDBBfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUDBBfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:35:43 -0500
Received: from main.gmane.org ([80.91.224.249]:31695 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263502AbUDBBfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:35:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.5-rc3-mm4
Date: Thu, 01 Apr 2004 20:35:32 -0500
Message-ID: <pan.2004.04.02.01.35.32.434379@triplehelix.org>
References: <20040401020512.0db54102.akpm@osdl.org> <200404011112.21212.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: three-cambridge-center-one-nineteen.mit.edu
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(pinging Sam Ravnborg)

On Thu, 01 Apr 2004 11:12:20 -0300, Norberto Bensa wrote:
> 	make: LANG: Command not found
> 	make: *** [all] Error 127
> 
> Workaround is:
> 
> 	LC_ALL= sudo make

This is not right. If you look in the Makefile for LC_ALL, you'll note
that the assignments are made having an indent in front of them (meaning:
execute as shell command.)

Convert those indents to spaces, and you're good to go. I'm not going to
bother submitting a patch because pan is surely going to munge it again.

-- 
Joshua Kwan

