Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWBBN01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWBBN01 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWBBN01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:26:27 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:15833 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751047AbWBBN00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:26:26 -0500
Date: Thu, 2 Feb 2006 15:26:14 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Nigel Cunningham <nigel@suspend2.net>
cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
In-Reply-To: <200602022228.20032.nigel@suspend2.net>
Message-ID: <Pine.LNX.4.58.0602021525210.13469@sbz-30.cs.Helsinki.FI>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
 <200602022131.59928.nigel@suspend2.net> <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com>
 <200602022228.20032.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2006, Nigel Cunningham wrote:
> Shouldn't the question be "Why are we making this more complicated by moving 
> it to userspace?"

It's less code in kernel now and in the future, more flexible (we have 
more options for compression and encryption in userspace), and less 
invasive. Specific points that make Suspend2 less attractive: it's a lot 
of code (500KB patch!), new compression code in kernel (LZF), dynamic page 
flags, and the special userspace notification mechanism 
(kernel/power/ui.c).

That being said, the biggest advantage for Suspend2 of course is that it's 
ready and stable now.

			Pekka
