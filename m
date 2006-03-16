Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWCPWL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWCPWL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWCPWL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:11:58 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:43994 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964880AbWCPWLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:11:55 -0500
Subject: Re: can I bring Linux down by running "renice -20
	cpu_intensive_process"?
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4419D575.4080203@tmr.com>
References: <441180DD.3020206@wpkg.org>
	 <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
	 <yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
	 <1142135077.25358.47.camel@mindpipe>
	 <yw1xk6azdgae.fsf@agrajag.inprovide.com>  <4419D575.4080203@tmr.com>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 17:11:48 -0500
Message-Id: <1142547108.9395.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 16:15 -0500, Bill Davidsen wrote:
> There's a good fix for this, don't give this guy root 
> any more ;-) 

Minor nit: s/root/realtime privileges/.  Since 2.6.12 these have been
decoupled.  No official distro release supports it OOTB yet (the
upcoming Ubuntu Dapper will).

Lee

