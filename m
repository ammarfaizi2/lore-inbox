Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVCISFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVCISFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVCISFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:05:47 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37002 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262152AbVCISCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:02:51 -0500
Subject: Re: [RFC] -stable, how it's going to work.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1sm35w3am.fsf@muc.de>
References: <20050309072833.GA18878@kroah.com>  <m1sm35w3am.fsf@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110391244.28860.208.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 18:00:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-03-09 at 09:56, Andi Kleen wrote:
> - It must be accepted to mainline. 

Strongly disagree. What if the mainline fix is a rewrite of the core API
involved. Some times you need to put in the short term fix. What must
never happen is people accepting that fix as long term.

How about

 - It must be accepted to mainline, or the accepted mainline patch be
deemed too complex or risky to backport and thus a simple obvious
alternative fix applied to stable ONLY.

