Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWHIWE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWHIWE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWHIWE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:04:56 -0400
Received: from xenotime.net ([66.160.160.81]:29609 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751393AbWHIWEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:04:55 -0400
Date: Wed, 9 Aug 2006 15:07:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Brian McGrew <brian@visionpro.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Upgrading kernel across multiple machines
Message-Id: <20060809150737.7a0c99ee.rdunlap@xenotime.net>
In-Reply-To: <C0FFA739.8986%brian@visionpro.com>
References: <C0FFA739.8986%brian@visionpro.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 14:52:41 -0700 Brian McGrew wrote:

> Hello,
> 
> I'm using a Dell PE1800 and I've built a new 2.6.16.16 kernel on the machine
> that works fine.  However, if I tar up /lib/modules/2.6.16.16 and /boot and
> move it onto another Dell PE1800 running the exact same software (FC3/Stock
> install) the new kernel doesn't boot.
> 
> On machine #1 life is good but moving it to machine #2, I get
> 
> /lib/ata_piix.ko: -l unknown symbol in module.
> 
> What am I missing?  Someone help please, I'm in a major time crunch!

Hi again,
Were you able to get any more kernel log messages?
They will say exactly which symbol(s) is missing.

Maybe adding "debug" to the kernel command line would produce more
messages, although many init scripts change that setting (ugh).

---
~Randy
