Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbTIVNcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbTIVNcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:32:39 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:23234 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263145AbTIVNci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:32:38 -0400
Subject: Re: DAC960: Bad Data Block Found
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: weez@freelists.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309211930.25350.weez@freelists.org>
References: <200309211930.25350.weez@freelists.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064237454.8592.18.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 14:30:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-22 at 01:30, John Madden wrote:
> DAC960#0: Error Condition MEDIUM ERROR on READ:
> DAC960#0:   /dev/rd/c0d0:   absolute blocks 405095..405102
> DAC960#0:   /dev/rd/c0d0p1: relative blocks 405032..405039
> DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Bad Data Block Found
> DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Bad Data Block Found
> DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Bad Data Block Found

Your controller seems to be logging disk errors. I guess run whatever
diagnostics the controller manual recommends and replace any dud drives

