Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVEMMoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVEMMoO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 08:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVEMMoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 08:44:14 -0400
Received: from alog0338.analogic.com ([208.224.222.114]:29326 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262349AbVEMMnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 08:43:52 -0400
Date: Fri, 13 May 2005 08:43:01 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Denis Vlasenko <vda@ilport.com.ua>
cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
In-Reply-To: <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com>
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
 <200505131522.32403.vda@ilport.com.ua> <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It would be good if the doom-sayers actually tried before then lied.....

Just in case anybody wants to try it:

int main()
{
     int x = 0x7fffff00;
     stime(&x);
}

Script started on Mon 18 Jan 2038 10:12:32 PM EST
[root@chaos root]# while true ; do date ; sleep 1 ; done
Mon Jan 18 22:12:44 EST 2038
Mon Jan 18 22:12:45 EST 2038
Mon Jan 18 22:12:46 EST 2038
Mon Jan 18 22:12:47 EST 2038
Mon Jan 18 22:12:48 EST 2038
[SNIPPED...]
Mon Jan 18 22:14:01 EST 2038
Mon Jan 18 22:14:02 EST 2038
Mon Jan 18 22:14:03 EST 2038
Mon Jan 18 22:14:04 EST 2038
Mon Jan 18 22:14:05 EST 2038
Mon Jan 18 22:14:06 EST 2038
Mon Jan 18 22:14:07 EST 2038
Fri Dec 13 15:46:09 EST 1901
Fri Dec 13 15:46:10 EST 1901
Fri Dec 13 15:46:11 EST 1901
Fri Dec 13 15:46:12 EST 1901
Fri Dec 13 15:46:13 EST 1901
Fri Dec 13 15:46:14 EST 1901
Fri Dec 13 15:46:15 EST 1901
Fri Dec 13 15:46:16 EST 1901
Fri Dec 13 15:46:17 EST 1901
Fri Dec 13 15:46:18 EST 1901
Fri Dec 13 15:46:19 EST 1901

[root@chaos root]# exit

Script done on Fri 13 Dec 1901 03:46:44 PM EST

As you can see, the machine still runs. There was a little
hickup in the 'sleep 1' it slept more than a second.

Remember to `rdate` your computer before you do any serious
work. The file-dates correctly show the new, before Unix, time and
date.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
