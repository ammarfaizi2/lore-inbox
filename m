Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030641AbWBQQ1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030641AbWBQQ1l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWBQQ1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:27:41 -0500
Received: from amdext3.amd.com ([139.95.251.6]:38281 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1030641AbWBQQ1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:27:40 -0500
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Fri, 17 Feb 2006 09:29:22 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Nick Warne" <nick@linicks.net>
cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       info-linux@ldcmail.amd.com, "Jean Delvare" <khali@linux-fr.org>
Subject: Re: Add LM82 support
Message-ID: <20060217162922.GP20157@cosmic.amd.com>
References: <20060216175930.GE20157@cosmic.amd.com>
 <LYRIS-4270-26349-2006.02.17-07.32.29--jordan.crouse#amd.com@whitestar.amd.com>
MIME-Version: 1.0
In-Reply-To: <LYRIS-4270-26349-2006.02.17-07.32.29--jordan.crouse#amd.com@whitestar.amd.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 17 Feb 2006 16:22:53.0627 (UTC)
 FILETIME=[6758D8B0:01C633DE]
X-WSS-ID: 6FEB27D72W4237852-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/06 13:09 +0000, Nick Warne wrote:
> '
> >                 if (kind <= 0) { /* identification failed */
> > @@ -296,10 +318,15 @@ static int lm83_detect(struct i2c_adapte
> >         if (kind == lm83) {
> >                 name = "lm83";
> >         }
> > +       else if (kind = lm82) {
> > +               name = "lm82";
> > +       }
> 
> Is that a '=' typo in the 'else if' there?

Yep - thats what that would be.  That must be my typo of the week, since
I just had it in another driver I'm writing.  I'll post a fixup here
very shortly with all the comments.

Jordan 

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

