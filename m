Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWCNBBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWCNBBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWCNBBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:01:17 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43437 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932524AbWCNBBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:01:16 -0500
Subject: Re: [Patch 1/9] timestamp diff
From: Lee Revell <rlrevell@joe-job.com>
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1142296939.5858.6.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142296939.5858.6.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 20:01:11 -0500
Message-Id: <1142298072.13256.70.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 19:42 -0500, Shailabh Nagar wrote:
> +       ret->tv_sec = end->tv_sec - start->tv_sec;
> +       ret->tv_nsec = end->tv_nsec - start->tv_nsec; 

What if end->tv_nsec is less than start->tv_nsec?

Lee

