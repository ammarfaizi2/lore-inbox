Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTDKXWL (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTDKXVW (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:21:22 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:60666 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262478AbTDKXUh (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:20:37 -0400
Message-ID: <3E9750A6.1050803@mvista.com>
Date: Fri, 11 Apr 2003 16:32:54 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Lars Marowsky-Bree <lmb@suse.de>, "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com> <3E9741FD.4080007@mvista.com> <20030411223856.GI21726@marowsky-bree.de> <3E974500.7050700@mvista.com> <20030411225818.GE3786@kroah.com>
In-Reply-To: <20030411225818.GE3786@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Fri, Apr 11, 2003 at 03:43:12PM -0700, Steven Dake wrote:
>  
>
>>Lars Marowsky-Bree wrote:
>>
>>    
>>
>>>On 2003-04-11T15:30:21,
>>> Steven Dake <sdake@mvista.com> said:
>>>
>>>
>>>
>>>      
>>>
>>>>There is no "spec" that states this is a requirement, however, telecom 
>>>>customers require the elapsed time from the time they request the disk 
>>>>to be used, to the disk being usable by the operating system to be 20 
>>>>msec.
>>>>  
>>>>
>>>>        
>>>>
>>>Heh. Yes, I've read that spec, and some of it involves some good crack 
>>>smoking
>>>;-) The current Linux scheduler will make that rather hard for you, you'll
>>>need hard realtime for such guarantees.
>>>
>>>      
>>>
>>Its quite easy to do if you are not dependent upon spawning an entire 
>>process to execute the insertion and creation even of the device node.
>>    
>>
>
>Then have the telcos live with the static /dev that they have today :)
>  
>
Unfortunately they are willing to live with devfs, but not a static 
/dev....  There are problems with devfs which I'm sure your well aware 
of which a dynamic /dev would solve...  But performance is an important 
goal.

>There's always a price to pay for new features...
>
>greg k-h
>
>Happily using his "pleasure boating" version of Linux...
>
>
>
>  
>

