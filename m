Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTFPHhB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 03:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTFPHhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 03:37:01 -0400
Received: from angband.namesys.com ([212.16.7.85]:19092 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262543AbTFPHhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 03:37:00 -0400
Date: Mon, 16 Jun 2003 11:50:51 +0400
From: Oleg Drokin <green@namesys.com>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can you trace a reiserfs error to the device or filesystem?
Message-ID: <20030616075051.GA12646@namesys.com>
References: <200306151724.49277.jbriggs@briggsmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306151724.49277.jbriggs@briggsmedia.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Jun 15, 2003 at 05:24:49PM -0400, joe briggs wrote:

> I get reiserfs errors like the ones below from my /var/log/syslog.  Is there a 
> way to tell what device they are coming from?

Unfortunatelly, no.
But we have patches that we hope to merge in mainline eventually.

> csi kernel: is_tree_node: node level 35718 does not match expected one 1
> csi kernel: vs-5150: search_by_key: invalid format found in block 9406, Fsck?
> csi kernel: vs-13050: reiserfs_update_sd: i/o failure occurred trying to 
> update [10145 51612 0x0 SD] stat datais_tree_node: node level 35718 does not 
> match the expected one 1 

Bye,
    Oleg
