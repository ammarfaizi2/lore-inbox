Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbVKCVlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbVKCVlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbVKCVlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:41:31 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:40937 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030507AbVKCVla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:41:30 -0500
Subject: Re: NTP broken with 2.6.14
From: john stultz <johnstul@us.ibm.com>
To: Jean-Christian de Rivaz <jc@eclis.ch>
Cc: linux-kernel@vger.kernel.org, dean@arctic.org, zippel@linux-m68k.org
In-Reply-To: <436A7D4B.8080109@eclis.ch>
References: <4369464B.6040707@eclis.ch>
	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>
	 <43694DD1.3020908@eclis.ch>
	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>
	 <43695D94.10901@eclis.ch>
	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>
	 <43697550.7030400@eclis.ch>
	 <1131046348.27168.537.camel@cog.beaverton.ibm.com>
	 <436A7D4B.8080109@eclis.ch>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 13:41:26 -0800
Message-Id: <1131054087.27168.595.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 22:12 +0100, Jean-Christian de Rivaz wrote:
> A have tested 7 differents vanilla kernel on the same suspect hardware:
> 
>                 2.6.8  : ntpd working : drift from    -77ppm to   -144ppm
>                 2.6.9  : ntpd working : drift from    -99ppm to   -231ppm
>                 2.6.10 : ntpd failed  : drift from -37825ppm to -29912ppm
>                 2.6.12 : ntpd failed  : drift from -43429ppm to -45251ppm

Ok, that makes it pretty clear we have a regression w/ 2.6.10. I really
appreciate your helping narrow down this issue. If you have the time,
could you test the three 2.6.10-rcX patches? 

You can find them here: 
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/

And they apply independently (not cumulatively) ontop of 2.6.9

thanks
-john



