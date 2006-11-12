Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753098AbWKLUhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbWKLUhs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 15:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbWKLUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 15:37:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22966 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753098AbWKLUhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 15:37:47 -0500
Subject: Re: What processor type?
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen.Clark@seclark.us
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4557534E.9040205@seclark.us>
References: <4557534E.9040205@seclark.us>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 12 Nov 2006 21:37:44 +0100
Message-Id: <1163363865.15249.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 12:01 -0500, Stephen Clark wrote:
> Hello List,
> 
> Could someone tell me what processor type I should select during kernel 
> config for
> an Intel Core 2 Duo T5600 chip.

the x86-64 "generic" option works best:

config GENERIC_CPU
        bool "Generic-x86-64"
        help
          Generic x86-64 CPU.


that one.



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

