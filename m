Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTDIA7E (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTDIA7E (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:59:04 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:59336 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261903AbTDIA7D (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:59:03 -0400
Date: Wed, 9 Apr 2003 02:10:23 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: convert_fxsr_from_user
Message-ID: <20030409011023.GA25834@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030409001344.GA20353@suse.de> <20030408165113.3af2a32e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408165113.3af2a32e.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 04:51:13PM -0700, Andrew Morton wrote:
 > It never has performed those checks.   The check is in the caller,
 > arch/i386/kernel/signal.c:restore_i387.

Ah, mixing my __'s up.
 
 > Bless you for merging Jon's uaccess.h documentation patch. 
 > My __get_user()'s are arse-about.

Yup, that's the bugger. Fixes the problem here.

		Dave
