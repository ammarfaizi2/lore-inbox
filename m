Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVDSUmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVDSUmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVDSUmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:42:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:40909 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261662AbVDSUmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:42:13 -0400
Subject: Re: /proc/cpuinfo format - arch dependent!
From: Lee Revell <rlrevell@joe-job.com>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050419200011.GB16594@schottelius.org>
References: <20050419121530.GB23282@schottelius.org>
	 <20050419132417.GS17865@csclub.uwaterloo.ca>
	 <1113938220.20178.0.camel@mindpipe>
	 <20050419200011.GB16594@schottelius.org>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 16:42:12 -0400
Message-Id: <1113943332.21038.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-19 at 22:00 +0200, Nico Schottelius wrote:
> Can you tell me which ones?
> 

Multimedia apps like JACK and mplayer that use the TSC for high res
timing need to know the CPU speed, and /proc/cpuinfo is the fast way to
get it.

Why don't you create sysfs entries instead?  It would be better to have
all the cpuinfo contents as one value per file anyway (faster
application startup).

Lee

