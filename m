Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269523AbUI3Vxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbUI3Vxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269535AbUI3Vxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:53:43 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32448 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269523AbUI3Vxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:53:35 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Jody McIntyre <realtime-lsm@modernduck.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, joq@io.com, torbenh@gmx.de
In-Reply-To: <20040930211408.GE4273@conscoop.ottawa.on.ca>
References: <1094967978.1306.401.camel@krustophenia.net>
	 <20040920202349.GI4273@conscoop.ottawa.on.ca>
	 <20040930211408.GE4273@conscoop.ottawa.on.ca>
Content-Type: text/plain
Message-Id: <1096581213.24868.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 17:53:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 17:14, Jody McIntyre wrote:
> I fixed the oops on boot by changing security_initcall() to late_initcall().  
> This moves initialization of the module to after /proc and sysctl is
> setup.
> 
> This patch still includes allcaps, which should be removed before it is
> merged.

Another issue that was raised was that the mlock stuff is also
unnecessary, because rlimits can do this now.  Is this the case?

Lee

