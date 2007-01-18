Return-Path: <linux-kernel-owner+w=401wt.eu-S1751981AbXARGpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbXARGpf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 01:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbXARGpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 01:45:35 -0500
Received: from www.osadl.org ([213.239.205.134]:54000 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751981AbXARGpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 01:45:34 -0500
Subject: Re: [PATCH] futex null pointer timeout
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, khilman@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <20070118002503.418478415@mvista.com>
References: <20070118002503.418478415@mvista.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 07:51:54 +0100
Message-Id: <1169103114.2941.241.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-17 at 16:25 -0800, Daniel Walker wrote:
> The patch reworks do_futex, and futex_wait* so a NULL pointer in the timeout
> position is infinite, and anything else is evaluated as a real timeout.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Ack.

	tglx


