Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161269AbWBVSKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbWBVSKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161287AbWBVSKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:10:33 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:47003 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161269AbWBVSKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:10:32 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Kay Sievers <kay.sievers@suse.de>
Cc: Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Robert Love <rml@novell.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
In-Reply-To: <20060222152743.GA22281@vrfy.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	 <20060217231444.GM4422@stusta.de>
	 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
	 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
	 <20060221225718.GA12480@vrfy.org>
	 <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
	 <20060222152743.GA22281@vrfy.org>
Date: Wed, 22 Feb 2006 20:10:29 +0200
Message-Id: <1140631830.11447.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kay,

On Wed, 2006-02-22 at 16:27 +0100, Kay Sievers wrote:
> Well, that's part of the contract by using an experimental version of HAL,
> it has nothing to do with the kernel, as long as it's under
> construction, you need to follow the latest releases.

That's not how you do it in a stable kernel. Please follow the proper
procedure and add it to Documentation/feature-removal-schedule.txt. In
the meanwhile, I sent a patch to Andrew to revert your change. Thanks.

			Pekka

