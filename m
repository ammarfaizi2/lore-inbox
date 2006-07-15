Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWGOFtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWGOFtL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 01:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbWGOFtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 01:49:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61112 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161059AbWGOFtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 01:49:10 -0400
Subject: Re: tighten ATA kconfig dependancies
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060715053418.GA5557@redhat.com>
References: <20060715053418.GA5557@redhat.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 07:49:08 +0200
Message-Id: <1152942548.3114.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-15 at 01:34 -0400, Dave Jones wrote:
> A lot of prehistoric junk shows up on x86-64 configs.


... but in general it helps compile testing if you're hacking stuff;
if your hacking IDE on x86-64 you now have to compile 32 bit as well to
see if you didn't break the compile for these as well

So please don't do this, just disable them in your config...

