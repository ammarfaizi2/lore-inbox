Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271188AbTHRCaH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 22:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271189AbTHRCaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 22:30:07 -0400
Received: from holomorphy.com ([66.224.33.161]:50148 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271188AbTHRCaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 22:30:04 -0400
Date: Sun, 17 Aug 2003 19:31:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Stefan Foerster <stefan@stefan-foerster.de>, linux-kernel@vger.kernel.org
Subject: Re: Very bad interactivity with 2.6.0 and SCSI disks (aic7xxx)
Message-ID: <20030818023107.GU32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Stefan Foerster <stefan@stefan-foerster.de>,
	linux-kernel@vger.kernel.org
References: <20030818013243.GB21665@in-ws-001.cid-net.de> <20030817192103.798994d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817192103.798994d8.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Foerster <stefan@stefan-foerster.de> wrote:
>> But as soon as I do a
>>  while true; do dd if=/dev/zero of=test bs=1024 count=1048576 ; rm test
>>  ; done
>>  on my SCSI disk, the system becomes completely unusuable after a few
>>  seconds.

On Sun, Aug 17, 2003 at 07:21:03PM -0700, Andrew Morton wrote:
> I've been running an aic7xx-based desktop on 2.5/2.6 for ages, no
> such problems.
> A kernel profile would be needed to diagnose this.  You could use
> readprofile, but as it may be an interrupt problem, the NMI-based oprofile
> output would be better.

39160 here, also no such issue.


-- wli
