Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTFZAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTFZAnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:43:52 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:48018 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S265291AbTFZAnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:43:18 -0400
Date: Thu, 26 Jun 2003 01:57:30 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [2.5 patch] small cleanups for amd-k8-agp.c
Message-ID: <20030626005729.GB18101@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <20030624171926.GP3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624171926.GP3710@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 07:19:26PM +0200, Adrian Bunk wrote:

 > the patch below does the following trivial cleanups to 
 > drivers/char/agp/amd-k8-agp.c:
 > - postfix three constants with ULL
 > - remove a variable that isn't needed
 > 
 > Please apply

Rejected. That whole block of code is bogus when run in 32 bit mode.
The ULL warnings that are currently emitted by gcc serve as reminders for
me to get off my arse and fix it some day.

	Dave

