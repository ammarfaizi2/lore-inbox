Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266677AbUHONAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUHONAl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 09:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUHONAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 09:00:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:15070 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266677AbUHONAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 09:00:39 -0400
Subject: Re: kernel-2.6.8.1 EIP is at velocity_netdev_event+0x16/0x50
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: George Georgalis <george@galis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040815095814.GA32195@trot.local>
References: <20040815095814.GA32195@trot.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092571091.17605.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 15 Aug 2004 12:58:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-15 at 10:58, George Georgalis wrote:
> Was able to save the following oops when I disabled assigning
> network ip addresses. Assigning an address at boot crashed
> hard -- did not write oops to log. kernel-2.6.8.1


Use the via_velocity driver from the -mm patches. The one in the
base kernel is still broken for some reason. You don't need all of -mm
just the via-velocity bits.

