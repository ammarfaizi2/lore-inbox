Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVKTRK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVKTRK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 12:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVKTRK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 12:10:26 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:22194
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751283AbVKTRKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 12:10:25 -0500
Subject: Re: I made a patch and would like feedback/testers
	(drivers/cdrom/aztcd.c)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Arjan van de Ven <arjan@infradead.org>
Cc: Daniel =?ISO-8859-1?Q?Marjam=E4ki?= <daniel.marjamaki@comhem.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1132501080.2857.3.camel@laptopd505.fenrus.org>
References: <43809652.8000904@comhem.se>
	 <1132501080.2857.3.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 20 Nov 2005 18:15:18 +0100
Message-Id: <1132506918.32542.70.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-20 at 16:38 +0100, Arjan van de Ven wrote:	>   		}
> > +		schedule_timeout_interruptible(1);
> 
> this I think is not quite right; schedule_timeout_*() doesn't do
> anything unless you set current->state to something.

Err, schedule_timeout_(un)interruptible sets current->state.

	tglx


