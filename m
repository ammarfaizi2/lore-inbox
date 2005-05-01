Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVEAWKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVEAWKA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVEAWJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:09:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38843 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261805AbVEAWGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:06:01 -0400
Date: Sun, 1 May 2005 23:06:23 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/22] UML - Cross-build support : mk_ptregs
Message-ID: <20050501220623.GJ13052@parcelfarce.linux.theplanet.co.uk>
References: <200505012112.j41LCNoE016402@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505012112.j41LCNoE016402@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 05:12:23PM -0400, Jeff Dike wrote:
> >From Al Viro:
> 
> 	mk_ptregs converted.  Nothing new here, it's the same situation
> as with mk_user_constants.

... and after that patch should be mk_sc conversion.  Another missing bit
(OTOH, that one might be in -mm already) is removal of -L/usr/lib in the
final link.
