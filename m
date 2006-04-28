Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWD1QL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWD1QL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWD1QL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:11:58 -0400
Received: from hera.kernel.org ([140.211.167.34]:59058 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030475AbWD1QL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:11:56 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: IP1000 gigabit nic driver
Date: Fri, 28 Apr 2006 09:08:39 -0700
Organization: OSDL
Message-ID: <20060428090839.42d975c8@localhost.localdomain>
References: <20060427142939.GA31473@fargo>
	<20060427185627.GA30871@electric-eye.fr.zoreil.com>
	<445144FF.4070703@cantab.net>
	<20060428075725.GA18957@fargo>
	<84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
	<20060428113755.GA7419@fargo>
	<Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
	<20060428153047.GA18959@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1146240519 32323 10.8.0.54 (28 Apr 2006 16:08:39 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 28 Apr 2006 16:08:39 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also consider consolidating into two files ip1000.c and ip1000.h, this allows
you to keep almost all the variables and functions static, and eliminates the
need for function prototypes for everything.
