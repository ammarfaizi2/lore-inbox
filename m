Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbVHPSoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVHPSoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVHPSoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:44:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62352 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030292AbVHPSoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:44:02 -0400
Subject: Re: [PATCH] input-driver-yealink-P1K-usb-phone
From: Lee Revell <rlrevell@joe-job.com>
To: Henk <Henk.Vergonet@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050816175322.GA3240@god.dyndns.org>
References: <20050816142144.GA2939@god.dyndns.org>
	 <1124206681.25596.20.camel@mindpipe> <20050816175322.GA3240@god.dyndns.org>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 14:44:00 -0400
Message-Id: <1124217841.26534.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 19:53 +0200, Henk wrote:
> Ehm, I did not know there was still an OSS usb driver.

Thankfully it's going away real soon.  It failed to depend on OSS,
didn't have decent help text, and doesn't live under Sound so lots of
people got them confused.  Most ALSA based distros failed to even
blacklist it by default so hotplug would load it preferentially to the
ALSA driver.  See the gazillion bug reports on the ALSA lists.

Lee

