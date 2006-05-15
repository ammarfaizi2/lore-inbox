Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWEOPUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWEOPUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWEOPUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:20:10 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:38849 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S964970AbWEOPUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:20:08 -0400
Date: Mon, 15 May 2006 08:20:08 -0700
From: thockin@hockin.org
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mcelog ?
Message-ID: <20060515152008.GA25367@hockin.org>
References: <20060515114243.8ccaa9aa.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515114243.8ccaa9aa.skraw@ithnet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 11:42:43AM +0200, Stephan von Krawczynski wrote:
> HARDWARE ERROR
> CPU 1: Machine Check Exception:                4 Bank 4: b60a200170080813
> TSC 89cfb4725b17 ADDR 1025cb3f0 
> This is not a software problem!
> Run through mcelog --ascii to decode and contact your hardware vendor
> Kernel panic - not syncing: Machine check
> 
> Of course I ran mcelog but I don't quite understand how the additional info
> helps me finding the problem.
> Is this a problem with RAM? And if, which one?

It sounds like a memory error, but there are some other bank4 errors that
can crop up.  What does mcedecode say?
