Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbVKPTmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbVKPTmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVKPTmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:42:44 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:4498 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030458AbVKPTmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:42:43 -0500
Subject: Re: OOPS - 2.6.14.2 | 2.6.15-rc1-git4 - qla2xxx
From: Lee Revell <rlrevell@joe-job.com>
To: Michele Baldessari <michele-lists@pupazzo.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051116193608.GA8500@michele.pupazzo.org>
References: <20051116193608.GA8500@michele.pupazzo.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 14:42:37 -0500
Message-Id: <1132170157.27215.63.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 20:36 +0100, Michele Baldessari wrote:
> Hi,
> 
> As per subject I get an OOPS on bootup with qla2xx cards using 2.6.14.2
> or 2.6.15-rc1-git4. Description follows:

This is not an Oops it's a soft lockup.  It means some program ran in
the kernel for a long time without rescheduling which is considered a
bug.

Lee

