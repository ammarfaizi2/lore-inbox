Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWHaReB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWHaReB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWHaReB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:34:01 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:3505 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932394AbWHaReA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:34:00 -0400
Date: Thu, 31 Aug 2006 19:30:00 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 01/16] GFS2: Core header files
In-Reply-To: <1157036840.3384.827.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0608311929100.19403@yvahk01.tjqt.qr>
References: <1157030918.3384.785.camel@quoit.chygwyn.com> 
 <Pine.LNX.4.61.0608311607441.5900@yvahk01.tjqt.qr> <1157036840.3384.827.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>or you could argue that the addition of a space (i.e. v. 2) would be
>correct since its an abbreviation, but point taken and I'll clean it up
>shortly.

Or spell it out, as in many GPL headers.

>> >+	/* Quota stuff */
>> >+
>> >+	struct gfs2_quota_data *al_qd[4];
>> 
>> What four quotas can there be? Use the MAXQUOTAS macro if feasible.
>> 
>[...]
>As a result there are the overall user/group limits and the local
>differences which are saved to by synced back to the master quota
>information, hence four of them.

Well, al_qd[2*MAXQUOTAS] then.


Jan Engelhardt
-- 
