Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266751AbUF3QvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbUF3QvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266770AbUF3QvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:51:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:44741 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266751AbUF3QvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:51:03 -0400
Subject: Re: Processes stuck in unkillable D state (2.4 and 2.6)
From: Chris Mason <mason@suse.com>
To: Rob Mueller <robm@fastmail.fm>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <007901c45ebc$5dc0b730$62afc742@ROBMHP>
References: <006a01c45de6$e4442930$62afc742@ROBMHP>
	 <1088604723.1589.1387.camel@watt.suse.com>
	 <007901c45ebc$5dc0b730$62afc742@ROBMHP>
Content-Type: text/plain
Message-Id: <1088614262.1589.1395.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 30 Jun 2004 12:51:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-30 at 10:58, Rob Mueller wrote:
> > Hi, could you please post the full sysrq-t output?
> 
> Sure. The 2 procs stuck in D state were 5873 and 15071.

Well, you've got two procs waiting for pages but it isn't entirely clear
why they aren't getting them.  There have been quite a few fixes in this
area since 2.6.4, how hard is it for you to upgrade?

-chris


