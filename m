Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTLCVty (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTLCVtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:49:53 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:20639 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S262174AbTLCVst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:48:49 -0500
Date: Wed, 3 Dec 2003 13:48:20 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: bill davidsen <davidsen@tmr.com>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
Message-ID: <20031203214819.GD11065@ca-server1.us.oracle.com>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>, willy@w.ods.org,
	linux-kernel@vger.kernel.org
References: <20031202002347.GD621@frodo> <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet> <bqlbuj$j03$1@gatekeeper.tmr.com> <200312032117.QAA20238@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312032117.QAA20238@gatekeeper.tmr.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 04:17:50PM -0500, bill davidsen wrote:
> In article <20031203204518.GA11325@alpha.home.local> you write:
> | I second this. I've already tested several 2.5 and 2.6-test, and I'm
> | really deceived by the scheduler. It looks a lot more as a hack to
> | satisfy xmms users than something usable. I'm doing 'ls -ltr' all the
> | day in directories filled with 2000 files, and it takes ages to complete.
> | I'm even at the point to which I add a "|tail" to make things go faster.
> 
> Just tried that, test11 seems better behaved. I've been running Nick's
> patches, for general use they work better for me, I can stand a skip a
> few times a day.

	Just another datapoint.  On my 300MHz PII laptop, ls and tab
completion often hang, taking up 100% CPU on -test11.  2.4.19-pre3-ac2,
my 2.4 kernel, doesn't even blip the CPU.
	That said, -test11 performs much better than 2.4.2[01], which
used to pause the system entirely for 30 seconds or more.
	If there are any knobs I can turn to tweak this, I'm interested.

Joel

-- 

Life's Little Instruction Book #347

	"Never waste the oppourtunity to tell someone you love them."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
