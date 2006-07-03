Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWGCJoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWGCJoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWGCJoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:44:18 -0400
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:28889 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1751046AbWGCJoR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:44:17 -0400
Date: Mon, 3 Jul 2006 11:44:15 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060703094415.GB22212@boogie.lpds.sztaki.hu>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060701181702.GC8763@irc.pl>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 08:17:02PM +0200, Tomasz Torcz wrote:

>   Yes, but what good is identification? We could only return I/O error.

I'm regularly using unison to sync my home directory to an USB drive,
and about once in every 2-3 weeks unison complains that the data on the
USB drive does not match the checksum unison expects. An umount/remount
usually fixes the problem. There are no messages in the kernel log.

It would be really nice if the file system should catch these silent
data corruptions and at least warn me that something is fishy.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
