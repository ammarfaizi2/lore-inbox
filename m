Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbTDFVoH (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbTDFVoH (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:44:07 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:12036
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263112AbTDFVoG (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 17:44:06 -0400
Date: Sun, 6 Apr 2003 17:50:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@aracnet.com>
Subject: Re: 2.5.65-preempt booting on 32way NUMAQ
In-Reply-To: <20030406214631.GP993@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0304061749570.2268-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304060625130.2268-100000@montezuma.mastecende.com>
 <20030406112340.GM993@holomorphy.com> <1049653846.753.156.camel@localhost>
 <20030406214631.GP993@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003, William Lee Irwin III wrote:

> On Sun, 2003-04-06 at 07:23, William Lee Irwin III wrote:
> >> All that's really left is driver and non-i386 arch coverage if I'm right.
> 
> On Sun, Apr 06, 2003 at 02:30:46PM -0400, Robert Love wrote:
> > If you know of something specific, please share.  I know the tty layer
> > needs work, but as far as I can tell, it is SMP issues that preemption
> > exposes... if any drivers in specific need work, let me know.
> 
> I presumed the audit was perpetual and/or ongoing.

Martin says the NUMAQ per node stuff isn't preempt safe, might be worth 
looking there too.

	Zwane
-- 
function.linuxpower.ca
