Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTFVLMX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 07:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264861AbTFVLMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 07:12:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38092
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261688AbTFVLMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 07:12:22 -0400
Subject: Re: [patch] ixj.c: EXPORT_SYMBOL of static functions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Ed Okerson <eokerson@quicknet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
In-Reply-To: <20030622010245.GA3763@fs.tum.de>
References: <20030622010245.GA3763@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056280986.2075.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jun 2003 12:23:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-22 at 02:02, Adrian Bunk wrote:
> drivers/telephony/ixj.c EXPORT_SYMBOL's two static functions.
> 
> Does this make any sense or is the patch below OK?

It's meant to export them. An exported static function is visible to
other modules.

