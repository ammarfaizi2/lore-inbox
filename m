Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTGFSAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 14:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTGFSAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 14:00:06 -0400
Received: from 69-55-72-144.ppp.netsville.net ([69.55.72.144]:56240 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S263129AbTGFSAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 14:00:03 -0400
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
From: Chris Mason <mason@suse.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030706183453.74fbfaf2.skraw@ithnet.com>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057515223.20904.1315.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Jul 2003 14:13:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-06 at 12:34, Stephan von Krawczynski wrote:
> Hello,
> 
> I just tried 2.4.22-pre3 and found out I cannot boot my test box any more. It
> halts at:
> 
> reiserfs: found format "3.6" with standard journal
> 
> on a partition located on aic7xxx based hd. 
> 
> Booting the box with pre2 works perfectly well.
> Anything I should try? What information is needed?

Same config here (reiserfs 3.6.x, aic7xxx drive), works without
problems.  Is reiserfs or aic7xxx compiled as a module in your setup? 
If so did you remember to install the new modules and mkinitrd (if
required).

Is reiserfs on your root drive?  If not can you please boot into single
user mode, enable sysrq, try the mount again and get the decoded output
from sysrq-p and sysrq-t if it hangs.

-chris


