Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbUCSXBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUCSXBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:01:42 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:5517 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263140AbUCSXBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:01:40 -0500
Date: Sat, 20 Mar 2004 00:01:36 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040319230136.GC7161@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <405B2127.8090705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405B2127.8090705@pobox.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Jeff Garzik wrote:

> - issue set-features command to get flush-cache into proper state 
> (enabled or disabled, as the user desires), if identify-device word 86 
> indicates it is not already in the state you seek.

BTW, speaking of identify-device, hdparm -i (which uses
HDIO_GET_IDENTITY) always returns "WriteCache=enabled" while hdparm -I
that uses HDIO_DRIVE_CMD with WIN_PIDENTIFY reports the "correct" state
that I've previously set with -W0. This is an i386 machine w/ 2.6.5-rc1.

Is HDIO_GET_IDENTITY working correctly?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
