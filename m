Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267795AbUHERYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267795AbUHERYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267796AbUHERYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:24:19 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:58324 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267795AbUHERYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:24:13 -0400
Date: Thu, 5 Aug 2004 19:21:59 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Hector Martin <hector@marcansoft.com>, Pasi Sjoholm <ptsjohol@cc.jyu.fi>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com, brad@brad-x.com, shemminger@osdl.org
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe RLT-8139 related)
Message-ID: <20040805192159.A12203@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.44.0408041915510.14609-100000@silmu.st.jyu.fi> <41120882.40302@marcansoft.com> <41121237.4050305@marcansoft.com> <20040805132233.A7430@electric-eye.fr.zoreil.com> <871xiltxhz.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <871xiltxhz.fsf@devron.myhome.or.jp>; from hirofumi@mail.parknet.co.jp on Fri, Aug 06, 2004 at 12:28:40AM +0900
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> :
[...]
> On the final analysis, what was the cause of this problem?

See answer 42

> I found the following in progguide-8100(100).pdf. Does this help something?

It makes sense. The previous code did not allow the ISR to be written under
any circumstance.

--
Ueimor
