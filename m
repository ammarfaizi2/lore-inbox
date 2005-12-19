Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVLSTUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVLSTUQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVLSTUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:20:16 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:50419 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964889AbVLSTUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:20:14 -0500
Date: Mon, 19 Dec 2005 11:16:54 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Joel Becker <joel.becker@oracle.com>, Kurt Hackel <kurt.hackel@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fs/ocfs2/: small cleanups
Message-ID: <20051219191654.GE4387@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20051217213056.GS23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217213056.GS23349@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 17, 2005 at 10:30:56PM +0100, Adrian Bunk wrote:
> This patch contains the following cleanups:
> - cluster/sys.c: make needlessly global code static
> - dlm/: "extern" declarations for variables belong into header files
>         (and in this case, they are already in dlmdomain.h)
That all looks good, thanks.

> BTW: Could you add a MAINTAINERS entry for ocfs2?
Yep. We've been meaning to add it for a while now. Thanks for pointing it
out.

Your patch and the new MAINTAINERS entry are in git now:
http://oss.oracle.com/git/ocfs2-dev.git
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

