Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbREQGgj>; Thu, 17 May 2001 02:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbREQGg3>; Thu, 17 May 2001 02:36:29 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:64516 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261238AbREQGgQ>;
	Thu, 17 May 2001 02:36:16 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105170635.f4H6Ztq456282@saturn.cs.uml.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
To: Mauelshagen@Sistina.com
Date: Thu, 17 May 2001 02:35:55 -0400 (EDT)
Cc: thomasko321k@gmx.at (Thomas Kotzian), helgehaf@idb.hist.no (Helge Hafting),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010516185845.A14397@sistina.com> from "Heinz J. Mauelshagen" at May 16, 2001 06:58:45 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heinz J. Mauelshag writes:

> LVM does a similar thing storing UUIDs in its private metadata
> area on every device used by it.
>
> Problem is: neither MD nor LVM define a standard in Linux
> which *needs* to be used on every device!
>
> It is just up to the user to configure devices with them or not.
>
> BTW: in case we had a Linux standard it wouldn't solve the
> "different OS" situation mentioned in this thread either.
>
>
> Generally speaking:
> 
> It is not the problem to reserve some space to store a uuid or
> something at such and such location on a device.
>
> The problem is the lack of a standard which eventually
> could be implemented in all OSes at some point in time.

The PC partition table has such an ID. The LILO change log
mentions it. I think it's 6 random bytes, with some restriction
about being non-zero.

