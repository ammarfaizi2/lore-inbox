Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312600AbSELLbN>; Sun, 12 May 2002 07:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312634AbSELLbM>; Sun, 12 May 2002 07:31:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35089 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312600AbSELLbK>;
	Sun, 12 May 2002 07:31:10 -0400
Date: Sun, 12 May 2002 12:31:09 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Hugh <hugh@nospam.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ > 15 for Athlon SMP boards
Message-ID: <20020512113109.GE726@gallifrey>
In-Reply-To: <3CDE48CC.9050003@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 12:25:58 up 1 day, 13:19,  3 users,  load average: 2.02, 2.25, 2.50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh (hugh@nospam.com) wrote:

> /proc/pci on my computer reports the following, which is definitely
> abnormal:

No, it is definitely normal - my happily working dual Athlon also has
IRQs above 15.  I think this is a consequence of the APICs and stuff on
newer x86 architectures (?) - but it is nothing to worry about.

> The symptom as you can see is that IRQ > 15, which does not seem
> normal.  I checked this with 2.4.18-pre6aa1 and 2.4.18-pre8ac1.
> The results were the same.  The consequence is that X does not
> start because of an error that reads like

Now you have put 2 and 2 together and got 5 here - the two are unlikely
to be related.

> =============================================================
> (WW) MGA No matching device section for instance (BusID PCI:1:5:0) found
> (EE) No devices detected
> ==================================================================

Hmm - I think thats a simple X config screw up; check that you haven't
got a BusID line in there which doesn't match.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
