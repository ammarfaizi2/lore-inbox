Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbUFGPmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUFGPmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUFGPmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:42:13 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:4501 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263182AbUFGPmK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:42:10 -0400
From: "Thomas Gleixner" <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
Organization: linutronix
To: Greg Weeks <greg.weeks@timesys.com>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [PATCH 2.4] jffs2 aligment problems
Date: Mon, 7 Jun 2004 17:36:53 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <40C484F9.20504@timesys.com>
In-Reply-To: <40C484F9.20504@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406071736.53101.tglx@linutronix.de>
X-Seen: false
X-ID: TWnXb2ZvgeNoKbxAZI-uoeuwhhfEwB175cWc8qcWg9kS3eiiJ6v6ww@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 June 2004 17:08, Greg Weeks wrote:
> This fixed some jffs2 alignment problems we saw on an IXP425 based
> XScale board. I just got pinged that I was supposed to post this patch
> in case anyone else finds it usefull. This was against a modified 2.4.19
> kernel.

Enable CONFIG_ALIGNMENT_TRAP instead of tweaking the code. 
JFFS2 / MTD must be allowed to do unaligned access

-- 
Thomas
________________________________________________________________________
Steve Ballmer quotes the statistic that IT pros spend 70 percent of their 
time managing existing systems. That couldn’t have anything to do with 
the fact that 99 percent of these systems run Windows, could it?
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

