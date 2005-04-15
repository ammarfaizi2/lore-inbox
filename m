Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVDODWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVDODWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 23:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVDODWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 23:22:32 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:61834
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261729AbVDODWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 23:22:25 -0400
Message-ID: <425F33E4.1070303@linuxwireless.org>
Date: Thu, 14 Apr 2005 22:24:20 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux support for IBM ThinkPad Disk shock prevention update...
References: <200504141658.50135.shawn.starr@rogers.com>	 <1113513316.19373.22.camel@mindpipe>	 <20050414224215.M94640@linuxwireless.org> <1113519832.19830.20.camel@mindpipe>
In-Reply-To: <1113519832.19830.20.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05-04-14 at 16:58 -0400, Shawn Starr wrote:

>>>>We just need to figure
>>>>out to get the specs from IBM
>>>>        
>>>>
>>>Best bet is probably reverse engineering it...
>>>      
>>>
>> 
>>Lee, 
>>
>>I know this is far from easy... but, What do we need to do this? I haven't
>>seen such a cooler feature in a Thinkpad like the HDAPS. (Well, maybe the
>>fingerprint reader) But, how can we / I help, if this is ever done?
>>
>>    
>>
>
>Please see:
>
>http://dxr3.sourceforge.net/re.html
>
>I have discovered several previously unknown emu10k1 hardware features
>using this procedure to reverse engineer the Windows drivers, including
>a per channel half loop interrupt, and added support to the Linux driver
>for some of them.
>
>It may be much easier to find the read and write register subroutines
>than in the above guide.  The Windows driver I was working with had
>exactly one subroutine that used the inb, inl, inw, outb, outw, outl
>instructions, so it was trivial to set breakpoints to log all the port
>I/O.  I later found it was even easier, the version of SoftIce I was
>using allows you to set I/O breakpoints, so all you need to start
>logging the register activity is the port.
>
>I had a little trouble loading the IDA symbols into SoftICE at first,
>just because the first few scripts I found on the net didn't work.
>
>Some devices use memory mapped IO, I have no idea how you would RE
>these.  Maybe someone else has some pointers?
>
>Lee
>  
>

The only thing I got back from IBM was:

       Please be advised, that the e-mail forum you
       have reached is provided for non-technical
       support and web registration issues of IBM.
       ave reached is provided for non-technical

       Please send your research proposal to IBM at
       T.J Watson Research Center at 914-945-3167.

I don't think I'm l33t enough like to call there and discuss for what we 
are looking for. Also they will probably tell me, " Ahh, well we 
currenly don't want to release anything because of legal issue" (Like I 
was already told)

- Alejandro
