Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262950AbSJFWvc>; Sun, 6 Oct 2002 18:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262951AbSJFWvb>; Sun, 6 Oct 2002 18:51:31 -0400
Received: from holomorphy.com ([66.224.33.161]:60631 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262950AbSJFWv3>;
	Sun, 6 Oct 2002 18:51:29 -0400
Date: Sun, 6 Oct 2002 15:54:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Gigi Duru <giduru@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021006225411.GI10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Aaron Lehmann <aaronl@vitelus.com>, Gigi Duru <giduru@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20021005193650.17795.qmail@web13202.mail.yahoo.com> <20021006004438.GG10722@holomorphy.com> <20021006222433.GB9785@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021006222433.GB9785@vitelus.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 03:24:33PM -0700, Aaron Lehmann wrote:
> It seems to me that what would be even better than patches is a
> general awareness of bloat and an attitude discouraging adding any
> bloat whatsoever to the base kernel. Proactive bloat prevention is a
> much better solution than asking embedded developers to send fixes
> whenever someone increases the size of the core kernel unnecessarily.
> Let's prevent a Mozilla here.

Beware here. The kinds of time/space tradeoffs important to you are
absolutely *not* apparent from "normal" testing. -You- are the embedded
developers and users. The onus is on you to find space consumption
problems visible in embedded environments.

Yes, I am highly concerned about space. But that is not enough to
address your needs. My space consumption concerns are largely
ZONE_NORMAL consumption and data structure proliferation. This is a
very different matter from boottime and absolute space consumption.

You will not be serviced by my own efforts to combat space consumption.
You must take action yourselves to provide both problem reports and
code to address these needs. But this is a valid activity and a
worthwhile direction to pursue. If you take action, it will be heeded.

Bill
