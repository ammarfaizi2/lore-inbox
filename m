Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVIIRsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVIIRsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbVIIRsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:48:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030287AbVIIRsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:48:08 -0400
Date: Fri, 9 Sep 2005 10:48:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@ZenIV.linux.org.uk
cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [sparse fix] (was Re: [PATCH] bogus cast in bio.c)
In-Reply-To: <20050909172938.GQ9623@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509091047530.3051@g5.osdl.org>
References: <20050909155356.GF9623@ZenIV.linux.org.uk> <je4q8u1agp.fsf@sykes.suse.de>
 <20050909163643.GO9623@ZenIV.linux.org.uk> <20050909172938.GQ9623@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> 
> So AFAICS proper fix for sparse should be to check thistype->as to see
> if it really has any intention to change ->as.  ACK?

Ack. Applied,

		Linus
