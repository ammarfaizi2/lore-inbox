Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWBOLAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWBOLAZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 06:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWBOLAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 06:00:25 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:63397 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751146AbWBOLAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 06:00:24 -0500
Date: Wed, 15 Feb 2006 13:00:22 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFT/PATCH] 3c509: use proper suspend/resume API
In-Reply-To: <20060215022523.1d21b9c9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0602151256580.14223@sbz-30.cs.Helsinki.FI>
References: <1139935173.22151.2.camel@localhost> <20060215022523.1d21b9c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006, Andrew Morton wrote:
> I have a 3c509, and I'm not afraid to use it!
> 
> Problem is, it doesn't resume correctly either with or without the patch:
> it needs rmmod+modprobe to get it going again.  (Which is better than the
> aic7xxx driver, which has a coronary and panics the kernel on post-resume
> reboot).

Is there anything in the logs to give us a clue what's going on? I can't 
see anything obvious looking at the code, but then again I don't have 
datasheets for 3c509 either.

			Pekka
