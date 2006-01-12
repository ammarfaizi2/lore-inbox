Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161291AbWALVPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWALVPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161296AbWALVPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:15:42 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:16332 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161291AbWALVPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:15:41 -0500
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
From: Lee Revell <rlrevell@joe-job.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jiri Slaby <slaby@liberouter.org>, Jon Mason <jdmason@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060112200735.GD5399@granada.merseine.nu>
References: <20060112175051.GA17539@us.ibm.com>
	 <43C6ADDE.5060904@liberouter.org>
	 <20060112200735.GD5399@granada.merseine.nu>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 16:15:38 -0500
Message-Id: <1137100539.2370.68.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 22:07 +0200, Muli Ben-Yehuda wrote:
> On Thu, Jan 12, 2006 at 08:28:30PM +0100, Jiri Slaby wrote:
> 
> > You should change alsa driver (sound/pci/trident/trident.c), rather than this,
> > which will be removed soon, I guess. And, additionally, could you change that
> > lines to use PCI_DEVICE macro?
> 
> This driver is not up for removal soon, as it supports a device that
> the alsa driver apparently doesn't (the INTERG_5050).

When were you going to report this?

Lee

