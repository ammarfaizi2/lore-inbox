Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSJDNrm>; Fri, 4 Oct 2002 09:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261729AbSJDNrm>; Fri, 4 Oct 2002 09:47:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43250 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261723AbSJDNrl>;
	Fri, 4 Oct 2002 09:47:41 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
To: Robert Varga <nite@hq.alert.sk>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFFB872C80.2A0F42E5-ON85256C48.004BEF31@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Fri, 4 Oct 2002 08:59:16 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/04/2002 09:53:03 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/04/2002 at 7:28 AM, Robert Varga wrote:
<snip...>
> Possibly shortened to:

> static inline int list_member(struct list_head *member)
> {
>     return member->next && member->prev;
> }

> Faster, and (at least to me) it looks more obvious.

Yes, this may be shorter. However with this change
the return type would also need to be changed to
portable across archs.

Mark


