Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTKCEqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 23:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTKCEqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 23:46:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:65254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261909AbTKCEqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 23:46:02 -0500
Date: Sun, 2 Nov 2003 20:45:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux-2.6.0-test9
In-Reply-To: <20031103045637.7d2acb90.us15@os.inf.tu-dresden.de>
Message-ID: <Pine.LNX.4.44.0311022042390.18647-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Nov 2003, Udo A. Steinberg wrote:
> 
> Yes, the kernel is UP + preempt. I'll try the current BK snapshot and will
> let you know should the problem occur again.

Btw, what compiler version do you have? The UP+preempt bug is a real bug,
but as far as I've been able to find out it's almost impossible to get gcc
to actually generate code that might trigger it. So while it's entirely
possible that the bug you're seeing is due to the (now fixed) UP+preempt 
bug, it's also quite possible that there's something else going on too.

			Linus

