Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSHIOyA>; Fri, 9 Aug 2002 10:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSHIOx7>; Fri, 9 Aug 2002 10:53:59 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:14861 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S313628AbSHIOx7>;
	Fri, 9 Aug 2002 10:53:59 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208091457.g79EvYr70722@saturn.cs.uml.edu>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
To: riel@conectiva.com.br (Rik van Riel)
Date: Fri, 9 Aug 2002 10:57:33 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), cmadams@hiwaay.net (Chris Adams),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0208091058140.23404-100000@imladris.surriel.com> from "Rik van Riel" at Aug 09, 2002 10:59:00 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Fri, 9 Aug 2002, Albert D. Cahalan wrote:
>
>> I almost put 99999, but then I realized that that's silly.
>> For years Linux had a hard limit of about 4000 processes,
>
> That limit was removed some 2 years ago.

Sure. Linux is 11 years old now. Also remember that that
was the _hard_ limit. We had a soft limit near 1000,
with a kernel recompile needed to increase it. Almost
everybody was satisfied with this.

Personally I'd change my adjustable PID limit to 999,
but I wouldn't suggest that as a default. 9999 should
cover almost all systems.

Self-adjusting could be nice. Then everybody starts
with 9, and gains a digit whenever space is 50% full.
