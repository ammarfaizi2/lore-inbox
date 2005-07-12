Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVGLURn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVGLURn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVGLURn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:17:43 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:19927
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262366AbVGLUQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:16:01 -0400
Subject: Re: [MTD] XIP cleanup
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050712200114.GA6165@suse.de>
References: <200507111906.j6BJ6fDu007639@hera.kernel.org>
	 <20050712200114.GA6165@suse.de>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 12 Jul 2005 22:19:12 +0200
Message-Id: <1121199552.26713.487.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 22:01 +0200, Olaf Hering wrote:

> How is that supposed to work?
> Should each arch provide their own header file?
> Should certion .config options depend on ARM or $FOO?
> I assume most of the mtd drivers are not intended for the average
> Walmart PC.

The dependency on ARM slipped through when I updated the git tree from
MTD-CVS. 

It's fixed in the MTD git tree.

tglx


