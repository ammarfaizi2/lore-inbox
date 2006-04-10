Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWDJStS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWDJStS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWDJStS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:49:18 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:8831 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932086AbWDJStR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:49:17 -0400
Date: Mon, 10 Apr 2006 11:46:04 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] CONFIGFS_FS must depend on SYSFS
Message-ID: <20060410184604.GZ29730@ca-server1.us.oracle.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20060326122552.GM4053@stusta.de> <20060327030622.GV7844@ca-server1.us.oracle.com> <20060410183522.GE2408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410183522.GE2408@stusta.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 08:35:22PM +0200, Adrian Bunk wrote:
> OTOH, there's the question whether it matters at all - is the 
> intersection of the people who are in such space-limited environments 
> that they are setting CONFIG_EMBEDDED=y and then CONFIG_SYSFS=n and
> the people using OCFS2 actually non-empty?

	We decided that (configfs + !sysfs == 0), and we just went with
the direct dependancy.  It's in my tree, going to Linus whenever it gets
there.

Joel

-- 

"I don't even butter my bread; I consider that cooking."
         - Katherine Cebrian

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
