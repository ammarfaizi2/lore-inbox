Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317880AbSFSNQO>; Wed, 19 Jun 2002 09:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317881AbSFSNQN>; Wed, 19 Jun 2002 09:16:13 -0400
Received: from ns.suse.de ([213.95.15.193]:16392 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317880AbSFSNQN>;
	Wed, 19 Jun 2002 09:16:13 -0400
Date: Wed, 19 Jun 2002 15:16:14 +0200
From: Dave Jones <davej@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/partitions broken in 2.5.23
Message-ID: <20020619151614.C29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andries Brouwer <aebr@win.tue.nl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619090248.GA8681@suse.de> <20020619113233.GA15730@win.tue.nl> <20020619134402.B29373@suse.de> <20020619125154.GA15739@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020619125154.GA15739@win.tue.nl>; from aebr@win.tue.nl on Wed, Jun 19, 2002 at 02:51:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 02:51:54PM +0200, Andries Brouwer wrote:

 > An extended partition is a box containing logical partitions.
 > It is almost always an error when people want to write directly to it
 > (confusing the extended partition with some logical partition inside).
 > After a number of reports of people who messed up their disk
 > by doing mkswap or mkfs on an extended partition I changed
 > the length of an extended partition to 1 block, enough for LILO
 > but stopping mkswap and mkfs.

Ah, that makes perfect sense to me now.

        Dave.


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
