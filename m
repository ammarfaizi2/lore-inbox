Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUDHS7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUDHS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:59:21 -0400
Received: from 213-0-217-98.dialup.nuria.telefonica-data.net ([213.0.217.98]:31881
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S262224AbUDHS7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:59:20 -0400
Date: Thu, 8 Apr 2004 20:59:03 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick.Holloway@pyrites.org.uk
Subject: Re: [PATCH 2.6] Add missing MODULE_PARAM to dummy.c (and MAINTAINERShip)
Message-ID: <20040408185903.GA21236@localhost>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	linux-kernel@vger.kernel.org, Nick.Holloway@pyrites.org.uk
References: <20040408174823.GA13335@localhost> <20040408105440.G22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408105440.G22989@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 08 April 2004, at 10:54:40 -0700,
Chris Wright wrote:

> this is going backwards.  module_param is the newer (preferred) interface.
> 
I (incorrectly) based my assumptions on the fact that "modinfo dummy"
didn't return any information about the module parameter. I also had a
look at some other modules, like "bonding", "rtl8139", and I assumed
that the MODULE_* macros were the 2.6.x way of doing things.

I was obviously wrong, sorry for the waste of time (anyways, it seems
there are several kernel modules waiting to be updated, maybe I should
give them a look and learn something and try to "fix" them).

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.5)
