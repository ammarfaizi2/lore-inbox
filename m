Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVGOBAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVGOBAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 21:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVGOBAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 21:00:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56268 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261732AbVGOBAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 21:00:07 -0400
Subject: Re: interrupt hooking in kernel 2.6
From: Lee Revell <rlrevell@joe-job.com>
To: Zvi Rackover <zvirack@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <28183df50507141755557b5145@mail.gmail.com>
References: <28183df50507141755557b5145@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 21:00:09 -0400
Message-Id: <1121389210.4535.100.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 03:55 +0300, Zvi Rackover wrote:
> hello all,
> 
> i wish to write a module for i386 that can hook interrupts. the module
> loads its own interrupt descriptor table instead of the default
> system's table. after executing my own handler(s), the old appropriate
> handler will be called.

I think you want the "I-Pipe", just posted to LKML few weeks ago.

Lee

