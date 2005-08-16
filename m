Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVHPVl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVHPVl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVHPVl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:41:26 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:54148 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932163AbVHPVl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:41:26 -0400
Subject: Re: 2.6.12.3 clock drifting twice too fast (amd64)
From: john stultz <johnstul@us.ibm.com>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Marie-Helene Lacoste <manies@tele2.fr>
In-Reply-To: <5a2cf1f6050816031011590972@mail.gmail.com>
References: <5a2cf1f6050816031011590972@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 14:41:22 -0700
Message-Id: <1124228482.8630.95.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 12:10 +0200, jerome lacoste wrote:
> Installed stock 2.6.12.3 on a brand new amd64 box with an Asus extreme
> AX 300 SE/t mainboard.
> 
> I remember seeing a message in the boot saying something along:
> 
>   "cannot connect to hardware clock."
> 
> And now I see that the time is changing too fast (about 2 seconds each second).
[snip]
> 0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5951

Looks like the AMD/ATI bug.

http://bugzilla.kernel.org/show_bug.cgi?id=3927

thanks
-john


