Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVCKFKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVCKFKr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbVCKFKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:10:47 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:7775 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262538AbVCKFKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:10:44 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       willy@debian.org, Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH, RFC 1/3] Add sem_getcount() to arches that lack it
X-Message-Flag: Warning: May contain useful information
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca>
	<20050310205503.6151ab83.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 10 Mar 2005 21:10:42 -0800
In-Reply-To: <20050310205503.6151ab83.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 10 Mar 2005 20:55:03 -0800")
Message-ID: <52fyz2938t.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Mar 2005 05:10:42.0337 (UTC) FILETIME=[AC562110:01C525F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> (Why do they want to do this anyway?)

Neither use seems really fundamental.  The XFS use is explicitly
inside #ifdef DEBUG and seems to be used only for assertions.
ieee1394 is just sticking the value in a read-only sysfs attribute.

 - R.
