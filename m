Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSGSWwG>; Fri, 19 Jul 2002 18:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSGSWwG>; Fri, 19 Jul 2002 18:52:06 -0400
Received: from flaske.stud.ntnu.no ([129.241.56.72]:29669 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S317058AbSGSWwF>; Fri, 19 Jul 2002 18:52:05 -0400
Date: Sat, 20 Jul 2002 00:55:07 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.4.18 and 2.4.19 problems
Message-ID: <20020719225507.GC14331@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <20020719192607.GA13880@stud.ntnu.no> <20020719140416.A25577@eng2.beaverton.ibm.com> <1027118177.7800.15.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027118177.7800.15.camel@UberGeek>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Austin Gonyou:
> Use SGI's XFS installer and move to XFS on those boxen. You will not be
> unhappy.

We're using reiserfs, and converting to XFS is out of the question,
sorry.

> Second suggestion, once you've installed a RH 7.3 XFS installed box,
> then go get 2.4.18-aa and recompile that and use it. 
> You will need to make a change to the scsi_scan.c file to add
> BLIST_LARGELUN support to which ever devices you're using. 

Why?  The vanilla kernel works fine with what we have in production,
but not with the new P4 Dual Xeon.

> (or use the 2.4.19-rc1-aa2 since it might be done already, assuming your
> using PV250's and up)

PV?  No, we're not using Dell's storage solutions, only their servers.


-- 
Thomas
