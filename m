Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbVKWIhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVKWIhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVKWIhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:37:32 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:13772
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030362AbVKWIhc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:37:32 -0500
Subject: Re: kthrt vs rt13
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Darren Hart <dvhltc@us.ibm.com>
Cc: "lkml," <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       "Stultz, John" <johnstul@us.ibm.com>
In-Reply-To: <4383A936.8020507@us.ibm.com>
References: <4383A936.8020507@us.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 23 Nov 2005 09:42:32 +0100
Message-Id: <1132735352.32542.111.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 15:26 -0800, Darren Hart wrote:
> I am trying to determine which ktimers / hrt related patches are part of the rt 
> series of patches and having some diffculty doing so.  I've heard it said that 
> the wish is for people to evaluate the rt series as a standalone patch, rather 
> than a collection of others.  I can understand this point of view, but in the 
> case where someone is migrating from a kthrt kernel to an rt kernel and wants to 
> verify that certain bugfixes etc have been applied, it would be very nice to be 
> able to see the patch series file.  Can anyone provide such a list?

Usually -rt contains the full -kthrt patch - except for a couple of
hours when updates happen. The fixes from -rt are pushed back into
-kthrt except for those which are -rt specific 

	tglx


