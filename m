Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTJ3LTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 06:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTJ3LTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 06:19:08 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:31751 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262355AbTJ3LTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 06:19:05 -0500
Subject: Re: Suspend to disk panicked in -test9.
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: rob@landley.net
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200310291857.40722.rob@landley.net>
References: <200310291857.40722.rob@landley.net>
Content-Type: text/plain
Message-Id: <1067512737.1228.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 30 Oct 2003 12:18:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-30 at 01:57, Rob Landley wrote:

> When is the last time that the screen blanking code actually accomplished 
> something useful?  These days it seems to exist for the purpose of destroying 
> panic call traces and annoying people.  (I seem to remember that pressing a 
> key used to make it come back, but now we're forced to use the input core 
> that no longer seems to be the case...)

I always do set "blankinterval" to 0 in drivers/char/vt.c before
compiling :-)

