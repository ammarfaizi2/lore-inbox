Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbSIRQec>; Wed, 18 Sep 2002 12:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbSIRQeb>; Wed, 18 Sep 2002 12:34:31 -0400
Received: from mout0.freenet.de ([194.97.50.131]:30433 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S267278AbSIRQe2>;
	Wed, 18 Sep 2002 12:34:28 -0400
Date: Wed, 18 Sep 2002 18:39:31 +0200
From: axel@hh59.org
To: linux-kernel@vger.kernel.org
Cc: pavel@suse.cz,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       shaggy@austin.ibm.com
Subject: 2.5.36: Software suspend fails with JFS filesystem
Message-ID: <20020918163931.GA198@prester.hh59.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, pavel@suse.cz,
	JFS-Discussion <jfs-discussion@www-124.ibm.com>,
	shaggy@austin.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this has happend ever since with JFS filesystem. I am trying to do sofware
suspend with "echo 4 > /proc/acpi/sleep".

The following errors are reported:

Stopping tasks: ========================
 stopping tasks failed (3 tasks remaining)
Suspend failed: Not all processes stopped!
Restarting tasks...<6> Strange, jfsIO not stopped
 Strange, jfsCommit not stopped
 Strange, jfsSync not stopped
 done

When I reported this first a whole while ago, someone said JFS still somehow
lacks support for software suspend.

# CONFIG_PREEMPT is not set

CONFIG_JFS_FS=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set


Best regards,
Axel
