Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbUKIQoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUKIQoC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUKIQoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:44:02 -0500
Received: from smtp.loomes.de ([212.40.161.2]:3805 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S261580AbUKIQlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:41:32 -0500
Subject: Re: 2.6.10-rc1-mm4
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041109074909.3f287966.akpm@osdl.org>
References: <20041109074909.3f287966.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 09 Nov 2004 17:41:28 +0100
Message-Id: <1100018489.7011.4.camel@lb.loomes.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 07:49 -0800, Andrew Morton wrote:

> - v4l updates, fbdev updates.

It does not link here on amd64 using an build-in BT848 driver.  

LD      vmlinux
drivers/built-in.o(.init.text+0xba4d): In function `p_radio':
: undefined reference to `bttv_parse'
make: *** [vmlinux] Error 1

__  
Markus


