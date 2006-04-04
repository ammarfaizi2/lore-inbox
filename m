Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWDDE0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWDDE0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 00:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWDDE0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 00:26:09 -0400
Received: from www.osadl.org ([213.239.205.134]:9619 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750810AbWDDE0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 00:26:08 -0400
Subject: Re: 2.6.16-rt11: Hires timer makes sleep wait far too long
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200604040340.k343ewe3029930@auster.physics.adelaide.edu.au>
References: <200604040340.k343ewe3029930@auster.physics.adelaide.edu.au>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 06:26:22 +0200
Message-Id: <1144124783.5344.396.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-04 at 13:10 +0930, Jonathan Woithe wrote:
> The actual amount of time waited by a "sleep 1" call from bash was tested
> at least twice for each timer source:
> 
>   pit: 12 seconds, 29 seconds, 28 seconds
>   tsc: 45 seconds, 45 seconds
>   acpi_pm: 45 seconds, 29 seconds
>   jiffies: 45 seconds, 32 seconds

Hmm, can you please send me your .config and the bootlog of the
machine ?

	tglx


