Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWELMJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWELMJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWELMJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:09:03 -0400
Received: from k2smtpout01-02.prod.mesa1.secureserver.net ([64.202.189.89]:29364
	"HELO k2smtpout01-01.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1751258AbWELMJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:09:01 -0400
X-Antivirus-MYDOMAIN-Mail-From: razvan.g@plutohome.com via plutohome.com.secureserver.net
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(82.77.255.201):SA:0(-2.4/5.0):. Processed in 0.646092 secs Process 5005)
Message-ID: <44647AEE.6040106@plutohome.com>
Date: Fri, 12 May 2006 15:09:18 +0300
From: Razvan Gavril <razvan.g@plutohome.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Coldpluging or USB Issues ?
References: <4462F4E1.4060008@plutohome.com> <20060511234452.GA18542@kroah.com>
In-Reply-To: <20060511234452.GA18542@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, May 11, 2006 at 11:25:05AM +0300, Razvan Gavril wrote:
>   
>> As far as i know since 2.6.15 there is a new coldplug mechanism using 
>> uevent and switching to a newer version of udevd that can do the cold 
>> plugging and replacing the old hotplug scripts would be the natural next 
>> step but before doing this i need to ask some questions like :
>> 1) Where there any changes sine 2.6.15 that could cause the old hotplug 
>> scripts to work reliable because most part of the time (95%) they are 
>> working ?
>>     
>
> I don't know, what is failing?
>
>   
Sometimes if fails to load the modules for the usb devices at boot but 
there are no step to reproduce, looks totally random and only on rare 
occasions if failing.
>> 2) Upgrading to newer version of udevd to let the udev scripts to do 
>> the coldpluging can solve any issues that where described ?
>>     
>
> Probably, that's what all of the major distros have already done.  It
> makes the startup logic much smaller and simpler.
>
> This should be continued on the linux-hotplug-devel mailing list if you
> are interested.
>
> thanks,
>
> greg k-h
>   
I know that most major distros made the switch, but does anything 
changed so it would make debian's hotplug scripts (and i don't thing 
they are only used on debian) incompatible with kernels greater than 
2.6.15 ? I cannot risk to upgrade to udev and have the same unstable 
platform. The most secure option that i have now is going back to 2.6.13 
if udev can't give me a satisfactory answer.

PS: I can't find any mailing list named linux-hotplug-devel as i would 
be more that happy to move my mail there.
