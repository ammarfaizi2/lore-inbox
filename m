Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288262AbSAHTdW>; Tue, 8 Jan 2002 14:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288263AbSAHTdD>; Tue, 8 Jan 2002 14:33:03 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:54286 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S288262AbSAHTcv>;
	Tue, 8 Jan 2002 14:32:51 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200201081932.g08JWfD287257@saturn.cs.uml.edu>
Subject: Re: can we make anonymous memory non-EXECUTABLE?
To: davidm@hpl.hp.com
Date: Tue, 8 Jan 2002 14:32:41 -0500 (EST)
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org,
        linux-ia64@linuxia64.org
In-Reply-To: <15419.17581.990574.160248@napali.hpl.hp.com> from "David Mosberger" at Jan 08, 2002 07:12:45 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger writes:

> I think that's fine.  If the consensus is that apps *should* use
> mprotect() to get executable permission (Linus implied as much) and
> it's an architecture specific choice as to whether this is enforced,
> I'm happy.  My belief is that we could make this change on ia64
> without undue burden on programmers.  If not, I'm sure I'll find out
> about it and I'm willing to take the responsibility.

If you turn off executable permission right now, you can add it
back at some future date.

If you leave the executable permission, we're stuck with it as
the ABI becomes set in stone.

So turn it off ASAP.

