Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWAITLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWAITLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWAITLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:11:35 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:64188 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750713AbWAITLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:11:34 -0500
Date: Mon, 9 Jan 2006 11:11:27 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Jeff Mahoney <jeffm@suse.com>
Cc: ocfs2-devel@oss.oracle.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2/dlm: fix compilation on ia64
Message-ID: <20060109191126.GF3313@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060109173640.GA25744@locomotive.unixthugs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109173640.GA25744@locomotive.unixthugs.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 12:36:40PM -0500, Jeff Mahoney wrote:
> 
>  Including <asm/signal.h> results in compilation failure on ia64 due to
>  not including <linux/compiler.h>
> 
>  Including <linux/signal.h> corrects the problem.
That looks good - thanks for the patch.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
