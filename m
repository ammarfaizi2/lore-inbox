Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUJCBSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUJCBSd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 21:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUJCBSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 21:18:32 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5288 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267657AbUJCBSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 21:18:24 -0400
Subject: Re: 2.6.9-rc3 lost cdrom
From: Lee Revell <rlrevell@joe-job.com>
To: Micha Feigin <michf@post.tau.ac.il>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041003021055.GA3227@luna.mooo.com>
References: <20041003021055.GA3227@luna.mooo.com>
Content-Type: text/plain
Message-Id: <1096766301.1375.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 02 Oct 2004 21:18:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-02 at 22:10, Micha Feigin wrote:
> I seem to have lost cdrom support through scsi emulation, any ideas?
> (its a burner, and drive detection with xcdroast in ide mode is
> terrible, takes minutes).

Sounds like an xcdroast bug.  If they finally dropped the scsi emulation
it would be a welcome change.  It does not make sense to have to use
some fake SCSI bus to burn CDs on an IDE system.

Lee 

