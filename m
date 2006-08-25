Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWHYQfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWHYQfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWHYQfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:35:40 -0400
Received: from mms3.broadcom.com ([216.31.210.19]:64015 "EHLO
	MMS3.broadcom.com") by vger.kernel.org with ESMTP id S1030183AbWHYQfk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:35:40 -0400
X-Server-Uuid: 450F6D01-B290-425C-84F8-E170B39A25C9
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: tg3 timeouts with 2.6.17-rc6
Date: Fri, 25 Aug 2006 09:35:28 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC093FAA4@NT-IRVA-0751.brcm.ad.broadcom.com>
In-Reply-To: <200608251049.52381.mdwyer@vprmail.tamu.edu>
Thread-Topic: tg3 timeouts with 2.6.17-rc6
Thread-Index: AcbIXjRrvz2SxCmXTSCw6XsK+/za9gABG3wA
From: "Michael Chan" <mchan@broadcom.com>
To: "Michael M. Dwyer" <mdwyer@vprmail.tamu.edu>
cc: linux-kernel@vger.kernel.org
X-TMWD-Spam-Summary: TS=20060825163531; SEV=2.0.2; DFV=A2006082506;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230342E34344546323541462E303032442D412D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006082506_4.00.0004_4.0-8
X-WSS-ID: 68F1F95B22G2030452-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael M. Dwyer wrote:

> I wasn't sure if BCM95751 was covered by "5780 class chips".

No, it's not covered but it also has the same problem.

2.6.18 will have an elegant fix for this problem on all affected
chips without disabling TSO.  In the meantime, I will send another
-stable patch for 2.6.17 to disable TSO on other remaining chips
affected by this problem.

Thanks.

