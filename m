Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWDEGqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWDEGqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 02:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWDEGqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 02:46:05 -0400
Received: from mail.charite.de ([160.45.207.131]:22949 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751120AbWDEGqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 02:46:04 -0400
Date: Wed, 5 Apr 2006 08:46:01 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.1: XFS internal error xfs_btree_check_lblock at line 215 of file fs/xfs/xfs_btree.c
Message-ID: <20060405064601.GP15722@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060404212144.GM15722@charite.de> <20060405080731.B1071351@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060405080731.B1071351@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Scott <nathans@sgi.com>:
> On Tue, Apr 04, 2006 at 11:21:44PM +0200, Ralf Hildebrandt wrote:
> > I was running xfs_fsr on our /home at night when this happened:
> > (Kernel 2.6.16.1)
> > ...
> > Apr  2 00:26:17 postamt kernel: Filesystem "sda5": XFS internal error xfs_btree_check_lblock at line 215 of file fs/xfs/xfs_btree.c.  Caller 0xb10dba58
> > Apr  2 00:26:17 postamt kernel:  [xfs_btree_check_lblock+82/407] xfs_btree_check_lblock+0x52/0x197
> 
> What does xfs_repair report?

The admin rebooted the box and it came up with no problems.

> Is it (the forced shutdown) reproducible?

I rather not nuke our mailbox server in mid-flight :)

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
