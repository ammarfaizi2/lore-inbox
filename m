Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTF0JmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 05:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTF0JmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 05:42:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:14384 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264115AbTF0JmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 05:42:04 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306270956.h5R9uH911387@devserv.devel.redhat.com>
Subject: Re: ICH5-SATA file corruption under 2.4.21-ac1
To: sflory@rackable.com (Samuel Flory)
Date: Fri, 27 Jun 2003 05:56:17 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com (Alan Cox),
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <3EFB77CD.1020607@rackable.com> from "Samuel Flory" at Meh 26, 2003 03:46:37 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   On an Intel winterpark motherboard I'm seeing file corruption when 
> using the onboard SATA interface.  The test I'm running is ctcs's new 
> kdiff test which just copies a kernel, diffs it, deletes the tree, and 
> starts over.  (Which seems to find file system issues like this pretty 
> quickly.) 

Random bit errors. This really doesn't look like an IDE layer problem
to be honest. 
