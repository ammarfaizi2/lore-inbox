Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264238AbRGDGYD>; Wed, 4 Jul 2001 02:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265967AbRGDGXx>; Wed, 4 Jul 2001 02:23:53 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:1043 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S264238AbRGDGXr>;
	Wed, 4 Jul 2001 02:23:47 -0400
Date: Wed, 4 Jul 2001 00:24:36 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010704002436.C1294@ftsoj.fsmlabs.com>
In-Reply-To: <200107040337.XAA00376@smarty.smart.net> <20010703233605.A1244@zalem.puupuu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010703233605.A1244@zalem.puupuu.org>; from galibert@pobox.com on Tue, Jul 03, 2001 at 11:36:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't such a crippling difference between straight-line and code with
unconditional branches in it with modern processors.  In fact, there's very
little measurable difference.

If you're looking for something to blame hurd performance on I'd suggest
the entire design of Mach, not inline asm vs procedure calls.  Tossing a
few context switches into calls is a lot more expensive.

} > In other words, if you know the push sequence of your C compiler's
} > function calls, you don't need asm("");.
} 
} You are very much forgetting _inline_ asm.  And if you think that's
} unimportant for performance, well, as Al would say, go back playing
} with Hurd.
