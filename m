Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263410AbTDSQYI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTDSQYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 12:24:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3339 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263410AbTDSQYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 12:24:07 -0400
Date: Sat, 19 Apr 2003 17:36:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-ID: <20030419173602.E4082@flint.arm.linux.org.uk>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030419180421.0f59e75b.skraw@ithnet.com> <200304191622.h3JGMI9L000263@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304191622.h3JGMI9L000263@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Sat, Apr 19, 2003 at 05:22:18PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 05:22:18PM +0100, John Bradford wrote:
> A RAID-0 array and regular backups are the best way to protect your
> data.

Correction.  RAID-0 is the best way to loose your data.  If any device
containing any part of the array goes down, you loose at least some of
your data.

RAID-1 is the redundant raid level, where each device in the set
contains a duplicate of the other device(s).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

