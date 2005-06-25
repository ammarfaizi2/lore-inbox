Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFYTPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFYTPO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 15:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFYTPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 15:15:14 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:26061
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261249AbVFYTPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 15:15:01 -0400
Message-ID: <42BD9F1E.5090407@linuxwireless.org>
Date: Sat, 25 Jun 2005 13:14:54 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <20050625144736.GB7496@atrey.karlin.mff.cuni.cz> <20050625150030.GA1636@ucw.cz>
In-Reply-To: <20050625150030.GA1636@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Sat, Jun 25, 2005 at 04:47:36PM +0200, Pavel Machek wrote:
>  
>
>>Hi!
>>
>>
>>    
>>
>>>>Yup, it's just doing port IO.  Get a kernel debugger for windows like
>>>>softice and this will be trivial to RE.
>>>>READ_PORT_USHORT / WRITE_PORT_UCHAR / READ_PORT_UCHAR
>>>>        
>>>>
>>>There are 3 ports involved.  The 0xed "non-existant delay port" and a pair
>>>of ports that are through the Super-I/O / IDE.  They are used in a
>>>index+value setup similar to reading/writing the AT keyboard
>>>      
>>>
>>>>controller.
>>>>        
>>>>
>>I think you got it... 2ports seem like enough for some kind of small
>>u-controller...
>>    
>>
> 
>Quite possibly the ACPI EC. Most likely a side entrance into the onboard 8042.
>
>  
>
Vojtech,

    What is the onboads 8042?

.Alejandro
