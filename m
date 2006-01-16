Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWAPGcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWAPGcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 01:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWAPGcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 01:32:09 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:56898 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750930AbWAPGcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 01:32:08 -0500
Date: Sun, 15 Jan 2006 22:28:44 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: kurt.hackel@oracle.com, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fs/ocfs2/dlm/dlmrecovery.c must #include <linux/delay.h>
Message-ID: <20060116062844.GE6373@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060114195510.GQ29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114195510.GQ29663@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 08:55:10PM +0100, Adrian Bunk wrote:
> fs/ocfs2/dlm/dlmrecovery.c does now use msleep(), and does therefore 
> need to #include <linux/delay.h> for getting the prototype of this 
> function.
That looks good - thanks Adrian.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

