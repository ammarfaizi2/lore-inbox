Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTGFVKN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 17:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTGFVKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 17:10:13 -0400
Received: from mail.ithnet.com ([217.64.64.8]:35850 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263759AbTGFVKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 17:10:08 -0400
Date: Sun, 6 Jul 2003 23:24:35 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030706232435.5e752f37.skraw@ithnet.com>
In-Reply-To: <1057515223.20904.1315.camel@tiny.suse.com>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
	<1057515223.20904.1315.camel@tiny.suse.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Jul 2003 14:13:44 -0400
Chris Mason <mason@suse.com> wrote:

> On Sun, 2003-07-06 at 12:34, Stephan von Krawczynski wrote:
> > Hello,
> > 
> > I just tried 2.4.22-pre3 and found out I cannot boot my test box any more.
> > It halts at:
> > 
> > reiserfs: found format "3.6" with standard journal
> > 
> > on a partition located on aic7xxx based hd. 
> > 
> > Booting the box with pre2 works perfectly well.
> > Anything I should try? What information is needed?
> 
> Same config here (reiserfs 3.6.x, aic7xxx drive), works without
> problems.  Is reiserfs or aic7xxx compiled as a module in your setup? 
> If so did you remember to install the new modules and mkinitrd (if
> required).

Hello Chris,

no, there is no modules involved here. The problem arises not on my root
partition (which happens to be reiserfs, too), that seems to be ok. Problems
seem to come up on sda4, a simple data partition.
 
> Is reiserfs on your root drive?  If not can you please boot into single
> user mode, enable sysrq, try the mount again and get the decoded output
> from sysrq-p and sysrq-t if it hangs.
> 
> -chris

I am going to try with single user tomorrow morning.

Regards,
Stephan
