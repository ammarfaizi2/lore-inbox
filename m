Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266359AbSKSPtj>; Tue, 19 Nov 2002 10:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSKSPtj>; Tue, 19 Nov 2002 10:49:39 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38887 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266359AbSKSPtj>; Tue, 19 Nov 2002 10:49:39 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211191556.gAJFuVG01731@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.47-ac6
To: davej@codemonkey.org.uk (Dave Jones)
Date: Tue, 19 Nov 2002 10:56:31 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20021119154518.GA560@suse.de> from "Dave Jones" at Nov 19, 2002 03:45:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and assorted IDE errors. had to use a 2.2 Debian install
> to get things off the ground. Strange how 2.2 IDE worked much
> better than 2.4's here.

Its puzzling but its also hopeful. The 2.4 code is a lot smarter so
all we have to do is figure out what smart things we do are not applicable
to the RadeonIGP.

I've backported the changes to the next 2.4.20-ac tree. Next stop is 
investigation of audio, usb and the great IDE mystery. You might want
to compare the 2.2 and 2.4 ali IDE and look for candidates that upset it.

