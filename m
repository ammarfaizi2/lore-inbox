Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318886AbSHWQN3>; Fri, 23 Aug 2002 12:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318903AbSHWQN3>; Fri, 23 Aug 2002 12:13:29 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:18447
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318886AbSHWQN2>; Fri, 23 Aug 2002 12:13:28 -0400
Subject: Re: interrupt handler
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: sanket rathi <sanket@linuxmail.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020823080728.21127A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020823080728.21127A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Aug 2002 12:17:10 -0400
Message-Id: <1030119432.863.3674.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 08:17, Richard B. Johnson wrote:

> Interrupts default to OFF within an interrupt handler. Given this,
> why would you use a spin-lock within the ISR on a single-processor
> machine?

Only the current interrupt handler is disabled... interrupts are
normally ON.

	Robert Love

