Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVBHUnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVBHUnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBHUnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:43:08 -0500
Received: from nevyn.them.org ([66.93.172.17]:54932 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261539AbVBHUnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:43:05 -0500
Date: Tue, 8 Feb 2005 15:43:01 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-ID: <20050208204300.GA18598@nevyn.them.org>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org> <20050208175106.GA1091@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208175106.GA1091@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 06:51:06PM +0100, Pavel Machek wrote:
> Hi!
> 
> > I wonder if reverting the patch will restore the old behaviour?
> 
> This seems to be minimal fix to get Kylix application back to the
> working state... Maybe it is good idea for 2.6.11?

Why does clearing the BSS fail?  Are the program headers bogus?
(readelf -l).

-- 
Daniel Jacobowitz
CodeSourcery, LLC
