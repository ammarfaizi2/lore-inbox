Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbSJOFhR>; Tue, 15 Oct 2002 01:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262369AbSJOFhR>; Tue, 15 Oct 2002 01:37:17 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:3559 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262290AbSJOFhR>;
	Tue, 15 Oct 2002 01:37:17 -0400
Message-ID: <3DABAACE.9040706@us.ibm.com>
Date: Mon, 14 Oct 2002 22:42:38 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
CC: "'Ben Greear'" <greearb@candelatech.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Re: Update on e1000 troubles (over-heating!)
References: <288F9BF66CD9D5118DF400508B68C44604758B78@orsmsx113.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:
>>Here is the lspci information, both -x and -vv.  This is with 
>>two of the e1000 single-port NICS side-by-side.  I have also 
>>strapped a P-IV CPU fan on top of the two cards to blow some 
>>air over them....running tests now to see if that actually 
>>helps anything.  If it does, I'll be sure to send you a picture :)
> 
> Ben, I checked the datasheet for the part shown in the lspci dump, and it
> shows an operating temperature of 0-55 degrees C.  You said you measured 50
> degrees C, so you're within the safe range.  Did the fans help?
> 
> Here's the datasheet:
> http://www.intel.com/network/connectivity/resources/doc_library/data_sheets/
> pro1000mt_sa.pdf

I get some strange e1000 failures too.  It usually involves the 
watchdog kicking them back into order, but sometimes they'll stay 
offline for a while.  Heat would explain it, though, because it only 
happens when I'm actually using the cards for a benchmark.  I figured 
that it was either my cables, or a shoddy switch.

The new dual-port e1000 that I have doesn't seem to have this problem, 
even though I'm running 4 times more traffic than the singles that I 
had.
-- 
Dave Hansen
haveblue@us.ibm.com

