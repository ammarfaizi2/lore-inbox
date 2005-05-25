Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVEYAV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVEYAV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 20:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVEYAV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 20:21:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:14233 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262177AbVEYAVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 20:21:54 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, Karim Yaghmour <karim@opersys.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, sdietrich@mvista.com
In-Reply-To: <429362BC.7060909@xenomai.org>
References: <Pine.OSF.4.05.10505241532040.29908-100000@da410.phys.au.dk>
	 <429362BC.7060909@xenomai.org>
Content-Type: text/plain
Date: Tue, 24 May 2005 20:21:52 -0400
Message-Id: <1116980512.2912.78.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 19:22 +0200, Philippe Gerum wrote:
> In fact, the benchmark code was 
> wrong, and has been amended by the author himself in a follow-up to
> the 
> initial article
>
> http://www.linuxdevices.com/articles/AT3479098230.html

printf() from an RT thread is a serious beginner mistake, and the author
does not seem to understand why.  He blames the problem on a change in
RTAI's behavior.

Lee  

