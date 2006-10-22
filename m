Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWJVIuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWJVIuY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWJVIuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:50:24 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:11342 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932286AbWJVIuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:50:23 -0400
Date: Sun, 22 Oct 2006 10:50:18 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: yhlu <yhlu.kernel@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Message-ID: <20061022085018.GO5211@rhun.haifa.ibm.com>
References: <200610212100.k9LL0GtC018787@hera.kernel.org> <20061022035109.GM5211@rhun.haifa.ibm.com> <86802c440610212355t237e171qf0dba82edc953066@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610212355t237e171qf0dba82edc953066@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 11:55:28PM -0700, yhlu wrote:

> can you try to add command line pci=routeirq?

Works.

> also if put the driver in the kernel?

Can't do that - it needs to be loaded late enough for the userspace
firmware request mechanism to work.

Cheers,
Muli
