Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263796AbTCVU0i>; Sat, 22 Mar 2003 15:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263797AbTCVU0i>; Sat, 22 Mar 2003 15:26:38 -0500
Received: from main.gmane.org ([80.91.224.249]:23750 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S263796AbTCVU0h>;
	Sat, 22 Mar 2003 15:26:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: IDE todo list
Date: Sat, 22 Mar 2003 15:33:46 -0500
Message-ID: <3E7CC8AA.7060501@myrealbox.com>
References: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>	 <20030322172453.GB9889@vana.vc.cvut.cz>	 <1048360040.9221.23.camel@irongate.swansea.linux.org.uk>	 <3E7CA555.9050203@myrealbox.com> <1048365383.9221.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sat, 2003-03-22 at 18:03, Nicholas Wourms wrote:
> 
>>The AMD Opus ide driver is also displaying symptoms of the 
>>same problem I had in 2.4.21-ac with UDMA100.  To refresh, 
>>it was detecting 80w as 40w and 40w as 80w [reverse logic]. 
>>  I am going to try the same fix which was posted for my 
>>2.4.21-ac problem.  I'll let you know if it worked...
> 
> 
> The cable detect stuff for AMD is fixed in the current driver
> I believe. Its not however full resynched into 2.5.6x yet. I
> need to finish merging the proc fixes into 2.4 before I do that
> 

Well unfortunately, even with out the little modification, 
bk-current now locks right after printing out the hdd 
geometry/partition info.  Apparently, something in the slew 
of patches which went in today has broke my setup. 
Unfortunately, I'm using the -mm3 patchset, so I can't say 
for certain that it isn't causing problems with the recently 
checked in code.  Any suggestions on how to go about 
debugging this?  I'm using a usb keyboard, so I don't think 
the Magic Sys-Req button will work at this point [Alas, KDB 
is currently non-functional for 2.5].

Cheers,
Nicholas


