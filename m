Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWCaRgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWCaRgc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWCaRgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:36:32 -0500
Received: from palrel10.hp.com ([156.153.255.245]:45187 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751094AbWCaRgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:36:31 -0500
Message-ID: <442D689E.9080209@hp.com>
Date: Fri, 31 Mar 2006 09:36:30 -0800
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during
 reset.
References: <20060330213928.GQ2172@austin.ibm.com>	<20060331000208.GS2172@austin.ibm.com>	<442C8069.507@wolfmountaingroup.com>	<20060331003506.GU2172@austin.ibm.com>	<442CACC0.1060308@wolfmountaingroup.com> <20060331170319.GV2172@austin.ibm.com>
In-Reply-To: <20060331170319.GV2172@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) What's wrong with taking deltas? Typical through-put performance
> measurement is done by pre-loading the pipes (i.e. running for
> a few minutes wihtout measuring, then starting the measurement).
> I'd think that snapshotting the numbers would be easier, and is 
> trivially doable in user-space. I guess I don't understand why 
> you need a new kernel featre to imlement this.

ftp://ftp.cup.hp.com/dist/networking/tools/beforeafter.tar.gz

Not my code, I've used it with success against ethtool -S output.

rick jones
