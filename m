Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUAST33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 14:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAST32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 14:29:28 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:10002 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261659AbUAST31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 14:29:27 -0500
Date: Mon, 19 Jan 2004 20:29:05 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: fire-eyes <sgtphou@fire-eyes.dynup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: atkbd.c errors + mouse errors with a belkin KVM
Message-ID: <20040119202905.A1073@pclin040.win.tue.nl>
References: <400C1D2F.7020503@fire-eyes.dynup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <400C1D2F.7020503@fire-eyes.dynup.net>; from sgtphou@fire-eyes.dynup.net on Mon, Jan 19, 2004 at 01:08:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 01:08:47PM -0500, fire-eyes wrote:

> I'm seeing some strange behavior using kernel 2.6.1 and a Belkin KVM.
> ... I often get the following error:
> 
> kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on 
> isa0060/serio0).

It is not really an error - the kernel is just being a bit noisy.
The 0x7a was really 0xfa, the ACK that a keyboard command succeeded.

Sooner or later the noise will go away. For now it is more interesting
to fix bugs in behaviour.

