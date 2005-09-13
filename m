Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVIMKWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVIMKWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 06:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVIMKWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 06:22:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21653 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932512AbVIMKWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 06:22:19 -0400
Date: Tue, 13 Sep 2005 12:20:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ACPI S3 and ieee1394 don't get along
Message-ID: <20050913102049.GA1876@elf.ucw.cz>
References: <200509131156.31914.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509131156.31914.lkml@kcore.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Running kernel 2.6.13.1, no patches.
> 
> Yesterday, after putting my laptop into S3 and reviving it at home, the firewire interface was
> unusable, no response when plugging in my external disk, loading sbp2 manually didn't trigger anything.
> 

Last time I checked, you could still break ohci1394 be repeatedly
loading it and unloading it. Fix that first...
							Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
