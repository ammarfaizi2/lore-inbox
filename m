Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbUKXSBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbUKXSBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 13:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKXRw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:52:58 -0500
Received: from fsmlabs.com ([168.103.115.128]:13213 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262806AbUKXRws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:52:48 -0500
Date: Wed, 24 Nov 2004 09:27:27 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 19/51: Remove MTRR sysdev support.
In-Reply-To: <1101295453.5805.263.camel@desktop.cunninghams>
Message-ID: <Pine.LNX.4.61.0411240922570.7171@musoma.fsmlabs.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
 <1101295453.5805.263.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, Nigel Cunningham wrote:

> This patch removes sysdev support for MTRRs (potential SMP hang and
> shouldn't be done with interrupts done anyway). Instead, we save and
> restore MTRRs when entering and exiting the processor freezers (ie when
> saving the registers & context for each CPU via an SMP call).

I take it this has been tested with AGP and X11 running?

Thanks,
	Zwane
