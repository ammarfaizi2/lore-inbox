Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWCKGKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWCKGKp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 01:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWCKGKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 01:10:43 -0500
Received: from fmr19.intel.com ([134.134.136.18]:2945 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750935AbWCKGKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 01:10:42 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <openib-general@openib.org>
Subject: RE: [PATCH 4/6 v2] IB: address translation to map IP toIB addresses (GIDs)
Date: Fri, 10 Mar 2006 22:10:38 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <ada1wx9hjfe.fsf@cisco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
thread-index: AcZEqVlP5CBYgxeeSwad+/Rn24ueEQAKQQ3w
Message-ID: <ORSMSX401FRaqbC8wSA00000019@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 11 Mar 2006 06:10:37.0998 (UTC) FILETIME=[844B34E0:01C644D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The ib_addr module depends on CONFIG_INET, because it uses symbols
>like arp_tbl, which are only exported if INET is enabled.
>
>I fixed this up by creating a new (non-user-visible) config symbol to
>control when ib_addr is built -- I put the following diff on top of
>your patch in my tree:

Thanks!
-Sean

