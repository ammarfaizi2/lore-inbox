Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269319AbUIYMr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269319AbUIYMr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 08:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUIYMr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 08:47:56 -0400
Received: from holomorphy.com ([207.189.100.168]:23784 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269319AbUIYMrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:47:55 -0400
Date: Sat, 25 Sep 2004 05:44:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OOM-killer killed everything
Message-ID: <20040925124441.GM9106@holomorphy.com>
References: <200409251326.13915.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409251326.13915.petkov@uni-muenster.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 01:26:13PM +0200, Borislav Petkov wrote:
> I just started burning an audio cd with cdrecord, ran it as root because of 
> the SUID changes in 2.6.8 when this big bad guy by the name of OOM-killer 
> appeared and started killing everything :) I don't know whether the spurious 
> interrupt issue has something to do with it but according to what I've read 
> on lkml about it until now, it is supposed to be quite harmless. Sysinfo 
> + .config attached.

Usually I only get "Kernel panic: Out of memory and no killable processes..."
from local DoS testcases; I'd be surprised if anyone tripped over such
cases by accident unless they're doing something particularly stressful
(e.g. forking server with zillions of clients) or there's a
particularly outrageously offensive memory leak.


-- wli
