Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTDMSMT (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 14:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTDMSMT (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 14:12:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17333 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261329AbTDMSMT (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 14:12:19 -0400
Date: Sun, 13 Apr 2003 19:24:05 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
Message-ID: <20030413182405.GG676@gallifrey>
References: <200304131407_MC3-1-3441-57C7@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304131407_MC3-1-3441-57C7@compuserve.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.66 (i686)
X-Uptime: 19:20:42 up 2 days, 6 min,  1 user,  load average: 0.04, 0.05, 0.06
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chuck Ebbert (76306.1226@compuserve.com) wrote:

>   OTOH you can come up with scenarios like, say, a DBMS doing 16K page
> aligned IO to raw devices where you might see big gains from making sure
> those 16K chunks didn't cross a physical cylinder boundary.

Maybe true; but figuring out where the drive really puts your sectors
these days ain't that easy; what with remapping and multiple different
densities on the platter.

Now given these discs have processors on board isn't it about time
someone improved the disc interface standards to push some of the
intelligence drivewards?  I guess with enough intelligence the drive
could do free block allocation and could do things like copying blocks
around for you.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
