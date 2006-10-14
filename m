Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422738AbWJNSFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWJNSFV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWJNSFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:05:21 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:30374 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1422738AbWJNSFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:05:21 -0400
Date: Sat, 14 Oct 2006 20:05:08 +0200 (CEST)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@p4.localdomain
To: Thomas Maier <balagi@justmail.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: [PATCH 1/2] 2.6.19-rc1-mm1 pktcdvd: init pktdev_major
In-Reply-To: <op.thfa3vzviudtyh@master>
Message-ID: <Pine.LNX.4.64.0610142003550.27769@p4.localdomain>
References: <op.tguqh5r2iudtyh@master> <m3k63emtma.fsf@telia.com>
 <op.thfa3vzviudtyh@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006, Thomas Maier wrote:

> pktdev_major must be initialized to 0.

No it doesn't. The BSS section is automatically initialized to 0. In fact, 
in the past there have been several patches for various parts of the 
kernel to remove explicit 0 initialization of global variables.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
