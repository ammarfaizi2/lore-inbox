Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966116AbWKJVst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966116AbWKJVst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966119AbWKJVst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 16:48:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37792 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S966116AbWKJVss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 16:48:48 -0500
Date: Fri, 10 Nov 2006 22:48:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tobias Oed <tobiasoed@hotmail.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com
Subject: Re: pdc202xx_old+suspend+smartctl -> hard lockup
Message-ID: <20061110214835.GA8017@elf.ucw.cz>
References: <BAY105-F1670EE9E2BA7C5866F5EFDA3F70@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY105-F1670EE9E2BA7C5866F5EFDA3F70@phx.gbl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hello, if I run
> smartctl -s on /dev/hde
> after suspending my machine to ram (echo mem > /sys/power/state), it locks 
> up with nothing on serial console, and no sysrq.
> If I move hde to hdd, I don't have the problem, so I suspect the problem 
> comes from my (on board) pdc20265 ide controller and not the drive.
> This is a fc6 system running a vanilla 2.6.18 kernel (the fc kernels have 
> the same issue) and smartd disabled.

Does suspend-to-disk work on same machine?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
