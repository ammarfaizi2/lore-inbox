Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVCaFvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVCaFvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 00:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVCaFvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 00:51:47 -0500
Received: from waste.org ([216.27.176.166]:64206 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261996AbVCaFvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 00:51:45 -0500
Date: Wed, 30 Mar 2005 21:51:41 -0800
From: Matt Mackall <mpm@selenic.com>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
Message-ID: <20050331055141.GH25554@waste.org>
References: <4249B2B8.1090807@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4249B2B8.1090807@poczta.onet.pl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 09:55:36PM +0200, Wiktor wrote:
> Hi all,
> 
> recently i had to run some program (xmms) with lowered nice value as 
> normal user.

See the new nice rlimit in recent -mm. This allows you to give various
users permission to raise priorities without root privileges.

-- 
Mathematics is the supreme nostalgia of our time.
