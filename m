Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265876AbUAUAJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUAUAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:09:50 -0500
Received: from adsl-218-142-97.jax.bellsouth.net ([68.218.142.97]:43815 "EHLO
	theorem093.dyndns.org") by vger.kernel.org with ESMTP
	id S265876AbUAUAJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:09:43 -0500
Date: Tue, 20 Jan 2004 19:10:40 -0500
From: Zack Winkles <winkie@linuxfromscratch.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: I2C sensors error (Re: 2.6.1-mm5)
Message-Id: <20040120191040.2e1b46a9.winkie@linuxfromscratch.org>
In-Reply-To: <20040120000535.7fb8e683.akpm@osdl.org>
References: <20040120000535.7fb8e683.akpm@osdl.org>
Organization: Linux From Scratch
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yo,

As usual, I've upgraded to the latest -mm, but to my dismay, my
temperature sensors are no longer reporting sane values.  For example,
my motherboard usually reports about 31C, but now never moves up or down
from 210C.  My CPU, likewise, hovers at 210C, but sometimes moves up or
down in what appears to be units of 11.

I'm positive in the correctness of my /sys value parsing (latest gkrellm
drop with lm_sensors values stuck in), so that's a non-issue.  The
modules I'm using are i2c_viapro and w83781d, and of course their
dependencies.  My logs report no errors from the kernel, or any user
space apps/libs of relevance.

If necessary, I can post my .config and anything else applicable.

Later,
Zack
