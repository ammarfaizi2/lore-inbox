Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267676AbUG3VhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267676AbUG3VhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUG3VhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:37:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37540 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267858AbUG3VgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:36:08 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Lee Revell <rlrevell@joe-job.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel <linux-kernel@vger.kernel.org>, tim.bird@am.sony.com,
       dsingleton@mvista.com
In-Reply-To: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
Content-Type: text/plain
Message-Id: <1091223388.800.88.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 17:36:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 15:11, Todd Poynor wrote:
> Any comments on this suggested patch that allows kernel command line
> parameter ide-delay=2 to set the probing delay to 2ms, or any insight
> into the risks involved in modifying this value?  Another possibility
> would be to configure the value in the IDE interface and device drivers
> according to known hardware characteristics.  Thanks.

Even if the default stays at 50, this patch is an improvement because it
replaces a magic number with a named value, which is never a bad thing. 
I will let you know the results on my system.

Lee

