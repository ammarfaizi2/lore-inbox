Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVG1JGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVG1JGN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVG1JGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:06:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:47326 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261389AbVG1JGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:06:09 -0400
Subject: Re: ppc: Sungem auto-negotiation problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ajay Patel <patela@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <90f56e4805072711341bc156d9@mail.gmail.com>
References: <90f56e4805072711341bc156d9@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 10:03:18 +0100
Message-Id: <1122541399.18835.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 11:34 -0700, Ajay Patel wrote:
> Hi,
> 
> I have a PowerMac G5. (Newer Model with SMU).
> It has a  Sungem ethernet with "PHY ID: 2060d2".
> 
> When this ethernet is connected to 
> "Tigon3 [partno(BCM95704A6) rev 2002 PHY(5704)] " or
> to the cisco switch, The PowerMac declares link up with
> 100 Mbs, while the other end declares link up  with 1000Mbs.
> In this setup both end cannot ping each other.
> 
> If I lower the speed of Tigon based adapter or Cisco's switch
> port to 100Mbs, both end can ping each other.
> 
> Is it a bug? or Am I missing something?

I posted a patch that might fix it a while ago. What kernel version have
you tested specifically ?

Ben.


