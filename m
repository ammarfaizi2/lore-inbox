Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbTIGR1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTIGR1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:27:47 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:19691 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263371AbTIGR1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:27:47 -0400
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, robert@schwebel.de
In-Reply-To: <20030907112813.GQ14436@fs.tum.de>
References: <20030907112813.GQ14436@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062955530.16972.11.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 07 Sep 2003 18:25:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This would be a good point to fix the winchip compile options properly
in 2.6 while you are at it. You should select -m486 (preferably
-m486 and then turn off the padding options)

