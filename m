Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVKEDMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVKEDMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 22:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVKEDMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 22:12:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:5769 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751164AbVKEDMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 22:12:20 -0500
Date: Sat, 5 Nov 2005 03:12:18 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: Balancing near the locking cliff, with some numbers
Message-ID: <20051105031218.GK7992@ftp.linux.org.uk>
References: <200511042056.59813.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511042056.59813.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 08:56:59PM +0100, Andi Kleen wrote:
> open:
> locks: 106 sems: 32 atomics: 50 rwlocks: 30 irqsaves: 89 barriers: 47

How long was the pathname and how much of that was in cache?
