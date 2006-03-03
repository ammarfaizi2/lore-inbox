Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752177AbWCCIdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbWCCIdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 03:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbWCCIdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 03:33:24 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:2205 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752177AbWCCIdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 03:33:23 -0500
Subject: Re: SEEK_HOLE and SEEK_DATA support?
From: Lee Revell <rlrevell@joe-job.com>
To: Jim Dennis <jimd@starshine.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060302214929.GA16523@starshine.org>
References: <20060302214929.GA16523@starshine.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 03:33:16 -0500
Message-Id: <1141374797.3042.95.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 13:49 -0800, Jim Dennis wrote:
> 
>  I ask primarily because of the interplay between 64-bit systems and
>  things like /var/log/lastlog (which appears as a 1.2TiB file due to
>  the nfsnobody UID of 4294967294).
> 
>  (I'm realize that adding support for these additional seek() flags
>  wouldn't solve the problem ... archiving tools would still have to
>  implement it.  And I can also hear the argument that Red Hat and other
>  distributions should re-implement lastlog handling to use a more modern
>  and efficient hashing/index format and perhaps that they should set
>  nfsnobody to "-1" ... 

So the presence of very high UIDs causes lastlog to be huge?  That just
sounds like a RedHat bug.

Lee

