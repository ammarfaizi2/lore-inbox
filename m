Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUCYQSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUCYQSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:18:33 -0500
Received: from ny03.mtek.chalmers.se ([129.16.60.203]:65292 "HELO
	ny03.mtek.chalmers.se") by vger.kernel.org with SMTP
	id S263232AbUCYQS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:18:27 -0500
Message-ID: <406302A9.8030805@am.chalmers.se>
Date: Thu, 25 Mar 2004 17:02:49 +0100
From: Thomas Svedberg <thsv@am.chalmers.se>
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040309)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eric.valette@free.fr
CC: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm2 still does not boot but it progress : seems to
 be console font related
References: <406172C9.8000706@free.fr>
In-Reply-To: <406172C9.8000706@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have these hangs as well, just tried 2.6.5-rc2-mm3 and they are still 
there.
However setting video=radeonfb:off as boot parameter solves the problem, 
if this can be of any help.
More info on request.

/Thomas

Eric Valette wrote:
> Andrew,
> 
> I have compiled a completely clean, unpatched (I mean except of course 
> rc2-mm2) and I can still not manage to finish booting. However, this 
> time, I get a little bit further AND system seems to hang exactly at the 
> same place each time (which was not the case with rc2-mm1). In fact I 
> managed to have the same behavior after removing the initramfs patches 
> from rc2-mm1 and fixing some other things using bk snapshots diffs (SCSI 
> st driver).

[snip]
-- 
/ Thomas
.......................................................................
  Thomas Svedberg
  Department of Applied Mechanics
  Chalmers University of Technology

  Address: SE-412 96 Göteborg, SWEDEN
  E-mail : thsv@am.chalmers.se, thsv@bigfoot.com
  Phone  : +46 31 772 1522
  Fax    : +46 31 772 3827
.......................................................................


