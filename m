Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTIVT3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTIVT3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:29:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15252 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261484AbTIVT3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:29:15 -0400
Date: Mon, 22 Sep 2003 20:29:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: torvalds@osdl.org, akpm@zip.com.au, thornber@sistina.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DM 1/6: Use new format_dev_t macro
Message-ID: <20030922192909.GG7665@parcelfarce.linux.theplanet.co.uk>
References: <200309221044.21694.kevcorry@us.ibm.com> <200309221051.27714.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309221051.27714.kevcorry@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 10:51:27AM -0500, Kevin Corry wrote:
> Use the format_dev_t function for target status functions.

[instead of bdevname, that is]

It's wrong.  Simply because "sdb3" is immediately parsed by admin and
08:13 is nowhere near that convenient.  These are error messages, let's
keep them readable.
