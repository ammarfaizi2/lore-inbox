Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTDKXeQ (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTDKXdl (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:33:41 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:31483 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261928AbTDKXcI (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:32:08 -0400
Message-ID: <3E97524B.2060001@mvista.com>
Date: Fri, 11 Apr 2003 16:39:55 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Lang <david.lang@digitalinsight.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Jeremy Jackson'" <jerj@coplanar.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <A46BBDB345A7D5118EC90002A5072C780BEBAA44@orsmsx116.jf.intel.com> <Pine.LNX.4.44.0304111347370.8422-100000@dlang.diginsite.com> <20030411205948.GV1821@kroah.com> <3E974299.3030701@mvista.com> <20030411225137.GB3786@kroah.com> <3E974F68.5020106@mvista.com> <20030411233248.GB4539@kroah.com>
In-Reply-To: <20030411233248.GB4539@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Fri, Apr 11, 2003 at 04:27:36PM -0700, Steven Dake wrote:
>  
>
>>Hmm, I thought you were creating a tmpfs in /dev.  I think that 
>>particular case would allow dnotify to tell you when permissions and 
>>owners changed?
>>    
>>
>
>My bad, you are correct.  Sorry, got confused there.
>
>Hm, does dnotify show events on a ramfs or tmpfs partition?  Haven't
>tried that out before.
>  
>
I have not tried it, but dnotify should be generic and not fs specific.  
If it doesn't work, it could be fixed to match other filesystem types...

>thanks,
>
>greg k-h
>
>
>
>  
>

