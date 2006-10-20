Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946411AbWJTOmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946411AbWJTOmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946417AbWJTOmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:42:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:38632 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946411AbWJTOmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:42:23 -0400
Date: Fri, 20 Oct 2006 09:42:21 -0500 (Central Daylight Time)
From: Dwayne Grant McConnell <decimal@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: Correct way to format spufs file output.
In-Reply-To: <200610201638.52404.arnd@arndb.de>
Message-ID: <Pine.WNT.4.64.0610200941530.5976@dwayne>
References: <Pine.WNT.4.64.0610182227120.6056@doodlebug> <200610201023.12796.arnd@arndb.de>
 <Pine.WNT.4.64.0610200848580.5976@dwayne> <200610201638.52404.arnd@arndb.de>
X-X-Sender: decimal@imap.linux.ibm.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Arnd Bergmann wrote:

> On Friday 20 October 2006 15:54, Dwayne Grant McConnell wrote:
> > I think %0xllx is the way to go. I would even advocate changing 
> > signal1_type and signal2_type unless it is actually too dangerous.
> 
> There is absolutely no reason why these should be hexadecimal, they
> are basically implementing a bool.
> 
> > Is there even a case where changing from %llu to %0xllx would break things? 
> > Perhaps with the combination of a old library with a new kernel?
> 
> Right, a library or some script that has been written assuming there
> is no leading 0x.

Okay. Thanks for considering it. I'll leave the %llu as is.

-- 
Dwayne Grant McConnell <decimal@us.ibm.com>
Lotus Notes Mail: Dwayne McConnell [Mail]/Austin/IBM@IBMUS
Lotus Notes Calendar: Dwayne McConnell [Calendar]/Austin/IBM@IBMUS

