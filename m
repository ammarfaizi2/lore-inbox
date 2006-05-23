Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWEWQm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWEWQm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWEWQmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:42:55 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:5584 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932069AbWEWQmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:42:55 -0400
Message-ID: <44733B8A.40807@oracle.com>
Date: Tue, 23 May 2006 09:42:50 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
Subject: Re: Question re: __mlog_cpu_guess in fs/ocfs2/cluster/masklog.h
References: <1148341507.2556.104.camel@mindpipe>	 <447329F4.7020007@oracle.com> <1148402074.12529.65.camel@mindpipe>
In-Reply-To: <1148402074.12529.65.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was wondering how it could not be a bug to use smp_processor_id in
> preemptible code, but I see that it's only used for debug output.  Sorry
> for the noise. 

No problem, thanks for taking a look in the first place.  We'll update
the comment to make it more explicit.

- z
