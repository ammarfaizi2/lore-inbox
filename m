Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUGOGbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUGOGbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 02:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUGOGbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 02:31:42 -0400
Received: from holomorphy.com ([207.189.100.168]:54178 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266128AbUGOGbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 02:31:41 -0400
Date: Wed, 14 Jul 2004 23:30:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Naveed Latif <naveedlatif786@yahoo.co.in>, linux-kernel@vger.kernel.org
Subject: Re: 7 GB RAM Drive
Message-ID: <20040715063058.GQ3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Naveed Latif <naveedlatif786@yahoo.co.in>,
	linux-kernel@vger.kernel.org
References: <20040715035459.91164.qmail@web8201.mail.in.yahoo.com> <40F62191.9090000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F62191.9090000@pobox.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Naveed Latif wrote:
>> hello dears,
>> I want to make a 7 GB RAM Disk.

On Thu, Jul 15, 2004 at 02:17:53AM -0400, Jeff Garzik wrote:
> Use ramfs.
> 	Jeff

rd.c has numerous issues beyond the performance/capacity -related ones
that are irreparable without invasive changes elsewhere in the kernel
(and similarly, the performance/capacity  issues require likewise). So
it would be best for him to do so if possible, yes. So I concur.


-- wli
