Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbSJDObH>; Fri, 4 Oct 2002 10:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261828AbSJDObF>; Fri, 4 Oct 2002 10:31:05 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:64435 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261826AbSJDObE>; Fri, 4 Oct 2002 10:31:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: "Mark Peloquin" <peloquin@us.ibm.com>, Robert Varga <nite@hq.alert.sk>
Subject: Re: [PATCH] EVMS core 2/4: evms.h
Date: Fri, 4 Oct 2002 09:03:44 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <OFFB872C80.2A0F42E5-ON85256C48.004BEF31@pok.ibm.com>
In-Reply-To: <OFFB872C80.2A0F42E5-ON85256C48.004BEF31@pok.ibm.com>
MIME-Version: 1.0
Message-Id: <02100409034403.02266@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 08:59, Mark Peloquin wrote:
> On 10/04/2002 at 7:28 AM, Robert Varga wrote:
> <snip...>
>
> > Possibly shortened to:
> >
> > static inline int list_member(struct list_head *member)
> > {
> >     return member->next && member->prev;
> > }
> >
> > Faster, and (at least to me) it looks more obvious.
>
> Yes, this may be shorter. However with this change
> the return type would also need to be changed to
> portable across archs.

What would the return type have to be?

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
