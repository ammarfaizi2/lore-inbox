Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTIPN06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTIPN06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:26:58 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:45988 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261881AbTIPN05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:26:57 -0400
Subject: Re: Kernel NMI error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: msrinath <msrinath@bplitl.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <004d01c37c47$0e6ef1e0$1d03000a@srinath>
References: <004d01c37c47$0e6ef1e0$1d03000a@srinath>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063718716.10036.10.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Tue, 16 Sep 2003 14:25:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-16 at 12:38, msrinath wrote:
> Recently one of our servers running RedHat linux 7.2 with 2.4.7-10 SMP
> kernel generated the following log and the system rebooted. This system has
> 2 CPUs.

Typically an NMI is a system error. That could be a memory error, it
could be a freak power glitch if its only ever happened once. 

If you are using a 2.4.7 kernel you really should also update to the
current errata kernel and other updates.


