Return-Path: <linux-kernel-owner+w=401wt.eu-S1751702AbXAPWIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbXAPWIm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbXAPWIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:08:42 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:42715 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbXAPWIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:08:40 -0500
Date: Wed, 17 Jan 2007 07:07:08 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, netdev@vger.kernel.org,
       xfs-masters@oss.sgi.com, xfs@oss.sgi.com, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com, minyard@acm.org,
       openipmi-developer@lists.sourceforge.net, tony.luck@intel.com,
       linux-mips@linux-mips.org, ralf@linux-mips.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-390@vm.marist.edu,
       paulus@samba.org, linuxppc-dev@ozlabs.org,
       linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de, vojtech@suse.cz,
       clemens@ladisch.de, a.zummo@towertech.it, rtc-linux@googlegroups.com,
       linux-parport@lists.infradead.org, andrea@suse.de, tim@cyberelk.net,
       philb@gnu.org, aharkes@cs.cmu.edu, coda@cs.cmu.edu,
       codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
Subject: Re: [PATCH 37/59] sysctl: C99 convert arch/sh64/kernel/traps.c and remove ABI breakage.
Message-ID: <20070116220708.GA10821@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	containers@lists.osdl.org, netdev@vger.kernel.org,
	xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
	minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	tony.luck@intel.com, linux-mips@linux-mips.org, ralf@linux-mips.org,
	schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	linux390@de.ibm.com, linux-390@vm.marist.edu, paulus@samba.org,
	linuxppc-dev@ozlabs.org, linuxsh-shmedia-dev@lists.sourceforge.net,
	ak@suse.de, vojtech@suse.cz, clemens@ladisch.de,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-parport@lists.infradead.org, andrea@suse.de, tim@cyberelk.net,
	philb@gnu.org, aharkes@cs.cmu.edu, coda@cs.cmu.edu,
	codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
	linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
	kurt.hackel@oracle.com
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656622749-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11689656622749-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 09:39:42AM -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> While doing the C99 conversion I notices that the top level sh64
> directory was using the binary number for CTL_KERN.  That is a
> no-no so I removed the support for the sysctl binary interface
> only leaving sysctl /proc support.
> 
> At least the sysctl tables were placed at the end of
> the list so user space did not see this mistake.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Looks good, thanks Eric.

Acked-by: Paul Mundt <lethal@linux-sh.org>
