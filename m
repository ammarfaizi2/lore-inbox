Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWCGXPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWCGXPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWCGXPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:15:21 -0500
Received: from mail.fieldses.org ([66.93.2.214]:29378 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S964796AbWCGXPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:15:21 -0500
Date: Tue, 7 Mar 2006 18:15:17 -0500
To: Neil Brown <neilb@suse.de>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Wrong error handling in nfs4acl
Message-ID: <20060307231517.GD14147@fieldses.org>
References: <1141761420.7561.7.camel@alice> <17422.4603.950948.166039@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17422.4603.950948.166039@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 10:06:35AM +1100, Neil Brown wrote:
> I think we want to change nfs4_acl_add_ace to return -ENOMEM rather
> than -1 too.

Whoops, yes, a search for "-1" in that file produces a number of dubious
returns.  I'll make a patch.

--b.
