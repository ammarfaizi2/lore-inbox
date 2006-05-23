Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWEWQeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWEWQeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWEWQeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:34:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33203 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750847AbWEWQeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:34:36 -0400
Subject: Re: Question re: __mlog_cpu_guess in fs/ocfs2/cluster/masklog.h
From: Lee Revell <rlrevell@joe-job.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
In-Reply-To: <447329F4.7020007@oracle.com>
References: <1148341507.2556.104.camel@mindpipe>
	 <447329F4.7020007@oracle.com>
Content-Type: text/plain
Date: Tue, 23 May 2006 12:34:33 -0400
Message-Id: <1148402074.12529.65.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 08:27 -0700, Zach Brown wrote:
> > Am I missing something?
> 
> The comment isn't particularly coherent and can be gotten rid of.  What
> puzzles you about the code?

I was wondering how it could not be a bug to use smp_processor_id in
preemptible code, but I see that it's only used for debug output.  Sorry
for the noise. 

Lee

