Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161563AbWJKWSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161563AbWJKWSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161565AbWJKWSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:18:48 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:63995 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161563AbWJKWSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:18:47 -0400
Date: Wed, 11 Oct 2006 15:18:22 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061011221822.GD7911@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Chandra Seetharaman <sekharan@us.ibm.com>,
	ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <20061011131935.448a8696.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011131935.448a8696.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 01:19:35PM -0700, Andrew Morton wrote:
> The patch deletes a pile of custom code from configfs and replaces it with
> calls to standard kernel infrastructure and fixes a shortcoming/bug in the
> process.  Migration over to the new interface is trivial and almost
> scriptable.

	The configfs stuff is based on the sysfs code too.  Should we
migrate sysfs/file.c to the same seq_file code?  Serious question, if
the cleanup is considered better.

Joel

-- 

"I almost ran over an angel
 He had a nice big fat cigar.
 'In a sense,' he said, 'You're alone here
 So if you jump, you'd best jump far.'"

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
