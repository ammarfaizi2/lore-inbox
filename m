Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWIWWqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWIWWqY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWIWWqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:46:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:33495 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750871AbWIWWqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:46:23 -0400
Subject: Re: Linux 2.6.16.30-pre1
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060923223348.GH5566@stusta.de>
References: <20060922222300.GA5566@stusta.de>
	 <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de>
	 <20060922230928.GB22830@kroah.com>
	 <20060923224909.69579243.khali@linux-fr.org>
	 <20060923223348.GH5566@stusta.de>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 18:47:54 -0400
Message-Id: <1159051675.1097.194.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 00:33 +0200, Adrian Bunk wrote:
> the main goals for 2.6.16 are:
> - no regressions
> - security fixes
> 
> And I did always say that things like adding new PCI IDs are
> considered 
> OK for 2.6.16. 

I think the point that people are trying to make is that adding new PCI
IDs carries an inherent risk of regression.  Unless you have access to
every device with that ID for regression testing it could be the
difference between a machine where one device doesn't work and a machine
that locks up hard.

Lee

