Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422749AbWAMRzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbWAMRzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbWAMRzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:55:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:58568 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422749AbWAMRzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:55:40 -0500
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, Jon Mason <jdmason@us.ibm.com>,
       Muli Ben-Yehuda <mulix@mulix.org>, Jiri Slaby <slaby@liberouter.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1137148102.3645.15.camel@localhost.localdomain>
References: <20060112175051.GA17539@us.ibm.com>
	 <43C6ADDE.5060904@liberouter.org>
	 <20060112200735.GD5399@granada.merseine.nu>
	 <20060112214719.GE17539@us.ibm.com>  <20060112220039.GX29663@stusta.de>
	 <1137105731.2370.94.camel@mindpipe>
	 <1137148102.3645.15.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 12:55:38 -0500
Message-Id: <1137174938.15108.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 10:28 +0000, Alan Cox wrote:
> Have you checked with the ARM people or the person who added support (
> pwaechtler@loewe-komp.de) ?
> 
> It's also used in various appliances people "adjust" to run Linux - the
> Philips AOL-TV for example. Also on the SH reference boards for the
> hitachi sh series cpus (arch/sh*).
> 

Yes he was the person I quoted in my previous message, who recommended
we drop it, but it looks like this device is more widely used than we
thought.

I agree that if there's any doubt then we should not remove code.

Lee 

