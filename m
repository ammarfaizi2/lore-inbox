Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTLQAND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 19:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTLQAND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 19:13:03 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56757 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262192AbTLQANA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 19:13:00 -0500
Message-ID: <3FDF9F88.7000705@labs.fujitsu.com>
Date: Wed, 17 Dec 2003 09:12:56 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Bryan Whitehead <driver@jpl.nasa.gov>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com> <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov> <3FDF95EB.2080903@labs.fujitsu.com> <20031216234024.GP4176@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031216234024.GP4176@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>Umm...  You do realize that if you have a shared writable mapping, the
>buffer contents _can_ change during the IO?  Legitimately.  When dirty


Thanks for telling me about it.
But this case, the broken data can be in an inode block.
And also the test script does not share any files. 
It just create,write,read and remove independent files.


Yoshihiro Tsuchiya:
>SCSI disk and IDE also.  The problem we observed in our driver was that 

We haven't tried it with IDE disk. Sorry. 

Thank you,
Yoshi
---
Yoshihiro Tsuchiya


