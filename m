Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271214AbTGWSyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271217AbTGWSyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:54:50 -0400
Received: from mail.gmx.de ([213.165.64.20]:56549 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271214AbTGWSyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:54:47 -0400
Date: Thu, 24 Jul 2003 00:39:29 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: different behaviour with badblocks on 2.6.0-test1-mm1-07int
Message-ID: <20030723190929.GB1288@home.woodlands>
Mail-Followup-To: Mike Fedyk <mfedyk@matchmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030722214253.GD1176@matchmail.com> <20030723081844.GB1324@home.woodlands> <200307231324.h6NDO5qj009710@turing-police.cc.vt.edu> <20030723151950.GA2218@home.woodlands> <20030723170107.GH1176@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723170107.GH1176@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Fedyk <mfedyk@matchmail.com> [2003-07-23 22:41]:
> > I am using 2.1.14.. Still no luck with it reading disks.. 
> 
> Maybe you need to mount sysfs on /sys?

Right, gkrellm does report some disk usage now, but it is far from
accurate. It registers barely any of the disk activity. Starting
Firebird or Opera may occasionally register one spike on the
graph. Mostly, the disk activity is not reported. 

This seems to be a gkrellm bug since vmstat reports disk usage more
accurately, although I haven't really looked closely at the output..

	- Apurva
