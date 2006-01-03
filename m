Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWACMz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWACMz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 07:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWACMz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 07:55:29 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:25482 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751392AbWACMz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 07:55:29 -0500
Date: Tue, 03 Jan 2006 07:55:27 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: New squawk in logwatch report?
In-reply-to: <1136287049.28634.70.camel@linux>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200601030755.27621.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200601022154.23484.gene.heskett@verizon.net>
 <1136287049.28634.70.camel@linux>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 06:17, Hans Kristian Rosbach wrote:
>On Mon, 2006-01-02 at 21:54 -0500, Gene Heskett wrote:
>> Greetings;
>>
>> Running 2.6.15-rc7, uptime 6d 23:43 atm.
>> Going thru the systems email output, I note this in the logwatch
>> file, something I don't recall seeing previously:
>>  --------------------- Kernel Begin ------------------------
>>
>> WARNING:  Kernel Errors Present
>>    smb_lookup: find contrib/ircstats2 failed, error=-5...:  1
>> Time(s) smb_proc_readdir_long: error=-2, breaking...:  2 Time(s)
>> smb_proc_readdir_long: error=-5, breaking...:  1 Time(s)
>> smb_proc_readdir_long: error=-512, breaking...:  1 Time(s)
>>
>>  ---------------------- Kernel End -------------------------
>>
>> Does anyone have a clue?  Other than its samba related, I have no
>> clue.
>
>I have no idea really, but I think samba is having problems finding
>the ircstats2 file/dir. Seems like that comes in contrib with mrtg.

mrtg is installed, but my router doesn't support it.  The cron job was 
stopped when I reverted from what I'd call a dane bramaged router that 
did support mrtg to a good one that didn't.  I spent a month screwing 
around, talking to tech support, flashing it with this and that test 
firmwares, etc and finally gave it up.  ANY router I can't ping and 
traceroute through is IMO drain bamaged.  A BEFSR41 Just Works(TM), 
but none of the vpn supporting models does.

>Other than that some googling suggests it might also be due to an
>incorrect/unreachable wins server specified in smb.conf.

No wins servers here, or defined in smb.conf on any of the 3 machines 
here.

If its repeated again in the logwatch for today, I'll investigate 
further.  And it is not.  The 3rd machine isn't currently smbmounted, 
nor does the script that refreshes the mounts every night mention the 
3rd box.  Its not always up, its out in the workshop, and runs my 
milling machine.  A Brain Dead Install of emc, running the dec 31 cvs 
version of emc2.  Sweet.

>-HK

Thanks HK.  Have a better 2006.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
