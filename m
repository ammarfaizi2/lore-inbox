Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUHLUdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUHLUdB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268768AbUHLUdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:33:00 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:42679 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268757AbUHLUcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:32:08 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nathan Bryant <nbryant@optonline.net>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20040812202622.GD14556@elf.ucw.cz>
References: <4119611D.60401@optonline.net>
	<20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net>
	<1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston>
	<1092314892.1755.5.camel@mulgrave> <20040812131457.GB1086@elf.ucw.cz>
	<1092328173.2184.15.camel@mulgrave> <20040812191120.GA14903@elf.ucw.cz>
	<1092339247.1755.36.camel@mulgrave>  <20040812202622.GD14556@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Aug 2004 16:31:51 -0400
Message-Id: <1092342716.2184.56.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 16:26, Pavel Machek wrote:
> Yes.

Well, that makes the suspend and resume functions rather complex. 
They're not going to be coded simply if we have to save and restore the
register state of the cards and reinitialise them.  I assume if you had
to pick three drivers to do this for, that would be aic7xxx, aic79xx and
sym_2?

James


