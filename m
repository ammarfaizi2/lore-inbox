Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269654AbUINUwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269654AbUINUwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269733AbUINUst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:48:49 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:7948 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S269796AbUINUpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:45:54 -0400
Date: Tue, 14 Sep 2004 21:45:53 +0100
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1/x86] The kernel is _always_ compiled with -msoft-float
Message-ID: <20040914204553.GF13788@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20040915021418.A1621@natasha.ward.six>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915021418.A1621@natasha.ward.six>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:14:18AM +0600, Denis Zaitsev wrote:
 > Why this kernel is always compiled with the FP emulation for x86?
 > This is the line from the beginning of arch/i386/Makefile:
 > 
 > CFLAGS += -pipe -msoft-float
 > 
 > And it's hardcoded, it does not depend on CONFIG_MATH_EMULATION.  So,
 > is this just a typo or not?

It deliberatly causes build failures if folks use fp math in their code.

		Dave

