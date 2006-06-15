Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030773AbWFOQ1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030773AbWFOQ1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030789AbWFOQ1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:27:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:12253 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030773AbWFOQ1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:27:05 -0400
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
From: Lee Revell <rlrevell@joe-job.com>
To: Voluspa <lista1@comhem.se>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, len.brown@intel.com, rdreier@cisco.com,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060615130336.176f527c.lista1@comhem.se>
References: <20060615010850.3d375fa9.lista1@comhem.se>
	 <4490B48E.5060304@oracle.com>  <20060615130336.176f527c.lista1@comhem.se>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 12:27:03 -0400
Message-Id: <1150388824.2925.105.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 13:03 +0200, Voluspa wrote:
> On Wed, 14 Jun 2006 18:14:54 -0700 Randy Dunlap wrote:
> > updated version:
> 
> As a user, it's great if this fixes people's keyboards and mice. But it's
> not a panacea. Gkrellm reads CPU temperatures from
> /proc/acpi/thermal_zone/*/temperature and that disturbs a time-critical
> application like mplayer, both when reading normal video and hacked mms:
> sound streams (ogg sound is OK, though):
> 

It would be helpful to analyze this with Ingo's latency tracing patch.

Lee


