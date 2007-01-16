Return-Path: <linux-kernel-owner+w=401wt.eu-S1751647AbXAPUtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbXAPUtG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbXAPUtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:49:06 -0500
Received: from rgminet02.oracle.com ([148.87.113.119]:22186 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbXAPUtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:49:02 -0500
Date: Tue, 16 Jan 2007 12:37:10 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, netdev@vger.kernel.org,
       xfs-masters@oss.sgi.com, xfs@oss.sgi.com, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com, minyard@acm.org,
       openipmi-developer@lists.sourceforge.net, tony.luck@intel.com,
       linux-mips@linux-mips.org, ralf@linux-mips.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-390@vm.marist.edu,
       paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de, vojtech@suse.cz,
       clemens@ladisch.de, a.zummo@towertech.it, rtc-linux@googlegroups.com,
       linux-parport@lists.infradead.org, andrea@suse.de, tim@cyberelk.net,
       philb@gnu.org, aharkes@cs.cmu.edu, coda@cs.cmu.edu,
       codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, kurt.hackel@oracle.com
Subject: Re: [PATCH 48/59] sysctl: Register the ocfs2 sysctl numbers
Message-ID: <20070116203710.GB6831@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656823041-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11689656823041-git-send-email-ebiederm@xmission.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 09:39:53AM -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> ocfs2 was did not have the binary number it uses under CTL_FS
> registered in sysctl.h.  Register it to avoid future conflicts,
> and change the name of the definition to be in line with the
> rest of the sysctl numbers.

This looks good - ACK.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
