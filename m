Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTD3Xf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTD3Xf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:35:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262538AbTD3Xf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:35:27 -0400
Date: Thu, 1 May 2003 00:47:46 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@digeo.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>, solt@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org, frankeh@us.ibm.com
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030430234746.GW10374@parcelfarce.linux.theplanet.co.uk>
References: <20030430121105.454daee1.akpm@digeo.com> <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com> <20030430162108.09dbd019.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430162108.09dbd019.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 04:21:08PM -0700, Andrew Morton wrote:
> menu if there was a kernel build happening at the same time.  That is just
> utterly broken, so if we're going to leave the sched.c code as-is then we
> *require* that all applications be updated to not spin on sched_yield.

Excuse me, but WTF do they spin on the sched_yield() in the first place?
_That_ sounds like utterly broken...
