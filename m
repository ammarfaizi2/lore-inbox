Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVFINXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVFINXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVFINVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:21:31 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:40462 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262389AbVFINM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 09:12:58 -0400
Message-ID: <42A8403A.2000909@shadowen.org>
Date: Thu, 09 Jun 2005 14:12:26 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Panin <pazke@donpac.ru>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.12-rc6-mm1
References: <20050607042931.23f8f8e0.akpm@osdl.org> <42A6FF41.5040109@shadowen.org> <20050609042705.GA19180@pazke>
In-Reply-To: <20050609042705.GA19180@pazke>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin wrote:

> Yeah, probably brown paper bag time... Please try the attached patch.

Ok.  I can confirm that linux-2.6.12-rc6-mm1 + just this fix boots fine
and works.  And yes I said works?  I can't understand why backing the
others out left us with the odd spin hang and this combination doesn't.
 I've managed to run 4 sets of boot and kernbench (10 runs) without a hang.

/me feels there is something else ugly in here we don't want but
unrelated to this patch.

-apw
