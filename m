Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265073AbUE0TQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbUE0TQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUE0TOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:14:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28370 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265073AbUE0TOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:14:41 -0400
Date: Tue, 25 May 2004 15:53:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040525135307.GK5215@openzaurus.ucw.cz>
References: <20040522013636.61efef73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522013636.61efef73.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Implementation of request barriers for IDE and SCSI.  The idea here is
>   that a filesystem can tag an IO request as a barrier and the disk will not
>   reorder writes across the barrier.  It provides additional integrity
>   guarantees for the journalling filesystems.  The feature is enabled for
>   reiserfs and ext3.

*Additional* guarantees? Is there anything we can garant
without request barriers?

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

