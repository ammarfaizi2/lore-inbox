Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161814AbWKIGq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161814AbWKIGq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 01:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161816AbWKIGq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 01:46:26 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:45782 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161814AbWKIGqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 01:46:25 -0500
Message-ID: <4552CE8D.8050902@in.ibm.com>
Date: Thu, 09 Nov 2006 12:15:33 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Mauricio Lin <mauriciolin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Jiffies wraparound is not treated in the schedstats
References: <3f250c710611081005v5fcf3236qfb10b47bab1ada5f@mail.gmail.com> <4552CAD9.1080603@in.ibm.com>
In-Reply-To: <4552CAD9.1080603@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
>
> hmm.. jiffies wrapped around in sched_info_depart()? I've never seen
> that happen.

I meant beyond the edge of the boundary twice or more. One overflow is handled
as explained in the previous mail.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
