Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTEMMjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTEMMjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:39:18 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:54773 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261159AbTEMMjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:39:17 -0400
Date: Tue, 13 May 2003 08:49:06 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] Use correct x86 reboot vector
To: "wingel@zoo.weinigel.se" <wingel@zoo.weinigel.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200305130851_MC3-1-38A3-A3B4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:

> BTW, what does Windows do here?  Whatever Windows is using should work
> with Linux too.

  I've only ever seen NT4/2K do a warm reboot, if that's relevant.

  FreeBSD unmaps every page in the machine and then flushes the
TLB as its last-resort reboot attempt.  I assume this causes a
triplefault...
