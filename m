Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWJLOBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWJLOBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWJLOBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:01:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46231 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751413AbWJLOBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:01:32 -0400
Date: Thu, 12 Oct 2006 14:59:45 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Heinz Mauelshagen <mauelshagen@redhat.com>
Subject: Re: dm stripe: Fix bounds
Message-ID: <20061012135945.GV17654@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Phillip Susi <psusi@cfl.rr.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Heinz Mauelshagen <mauelshagen@redhat.com>
References: <20060316151114.GS4724@agk.surrey.redhat.com> <452DBE11.2000005@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452DBE11.2000005@cfl.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 12:01:21AM -0400, Phillip Susi wrote:
> now dmraid fails to configure the dm 
> table because this patch rejects it.
 
> I believe the correct thing to do is to special case the last stripe in 
> 0-31    64-67
> 32-63   68-71
 
AFAIK current versions of dmraid handle this correctly - Heinz?

Alasdair
-- 
agk@redhat.com
