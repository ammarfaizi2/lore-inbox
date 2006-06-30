Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWF3VDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWF3VDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWF3VDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:03:48 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:23440 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932069AbWF3VDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:03:47 -0400
Subject: Re: SATA in 2.6.17 vs 2.6.15 (x86/ICH6)
From: Lee Revell <rlrevell@joe-job.com>
To: William Thompson <wt@electro-mechanical.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060630184156.GA8086@electro-mechanical.com>
References: <20060630184156.GA8086@electro-mechanical.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 17:04:00 -0400
Message-Id: <1151701440.32444.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 14:41 -0400, William Thompson wrote:
> *** I'm not on the list, please always keep me in CC ***
> 
> The speed of SATA in 2.6.17 is significantly lower in my test than 2.6.15.
> 
> In .15, I would see over 10mb/sec avg writing over 16,000 files (~2.4gb) to a
> fat32 partition.
> 
> In .17, I see it start at 2-3mb/sec and work it's way down to 500kb/sec
> towards the end.  Even the system is not as responsive (The system's / is a
> tmpfs which all programs, including /usr, are stored), not even when using
> ssh.
> 
> I used the same .config in .17 as I did with .15 (make oldconfig)

What does the oprofile output look like for both cases?

Lee

