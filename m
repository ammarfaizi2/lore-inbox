Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVJ3Omk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVJ3Omk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVJ3Omk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:42:40 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:10964 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750706AbVJ3Omk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:42:40 -0500
Subject: Re: [2.6 patch] mm/: small cleanups
From: Dave Hansen <haveblue@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051030010508.GU4180@stusta.de>
References: <20051030010508.GU4180@stusta.de>
Content-Type: text/plain
Date: Sun, 30 Oct 2005 15:42:32 +0100
Message-Id: <1130683352.12551.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-30 at 02:05 +0100, Adrian Bunk wrote:
> This patch contains the following cleanups:
> - make some needlessly global functions static
> - vmscan.c: #if 0 the unused global function sys_set_zone_reclaim

If it's truly unused, why not simply kill it completely?

-- Dave

