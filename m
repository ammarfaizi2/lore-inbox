Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUF3Mhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUF3Mhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUF3Mhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:37:53 -0400
Received: from gprs214-119.eurotel.cz ([160.218.214.119]:46214 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266561AbUF3Mhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:37:47 -0400
Date: Wed, 30 Jun 2004 14:37:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] Provide console_suspend() and console_resume()
Message-ID: <20040630123727.GA16409@elf.ucw.cz>
References: <20040614151217.H14403@flint.arm.linux.org.uk> <20040614151307.I14403@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614151307.I14403@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add console_suspend() and console_resume() methods so the serial drivers
> can disable console output before suspending a port, and re-enable output
> afterwards.

Could it be called console_stop()/console_start()? suspend/resume
sounds like power managment, and it is unrelated....
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
