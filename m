Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933076AbWKMVkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933076AbWKMVkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933078AbWKMVkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:40:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:32930 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933076AbWKMVkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:40:09 -0500
Subject: Re: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: anton@au1.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <45586EB5.40409@in.ibm.com>
References: <45586EB5.40409@in.ibm.com>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 08:39:55 +1100
Message-Id: <1163453995.5940.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 18:40 +0530, Srinivasa Ds wrote:
> Hi
> when I tried to hot plug a cpu on IBM bladecentre JS20 system,it dropped 
> in to xmon. On analyzing the problem,I found out that "self-stop" token  
> is not exported
> to the OS through rtas(Could be verified by looking in to 
> /proc/device-tree/rtas file).

Please CC powerpc related patches to linuxppc-dev@ozlabs.org


