Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbUBBIqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 03:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265653AbUBBIqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 03:46:47 -0500
Received: from pop.gmx.net ([213.165.64.20]:26809 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265648AbUBBIqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 03:46:44 -0500
X-Authenticated: #4512188
Message-ID: <401E0E66.4040905@gmx.de>
Date: Mon, 02 Feb 2004 09:46:30 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@gentoo.org>
CC: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       zander@mail.minion.de
Subject: Re: [ANNOUNCE] udev 015 release
References: <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de>	 <20040130172310.GB5265@kroah.com> <1075649046.24826.8.camel@nosferatu.lan>
In-Reply-To: <1075649046.24826.8.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> On Fri, 2004-01-30 at 19:23, Greg KH wrote:
> 
>>On Fri, Jan 30, 2004 at 05:45:41PM +0100, Prakash K. Cheemplavam wrote:
>>
>>>Hi Greg,
>>>
>>>perhaps you remember me being a gentoo user wanting to switch to udev. 
>>>Well I did so, but am having some problems:
>>>
>>>1.) Minor one: Nodes for Nvidia (I am using binary display modules 
>>>1.0.5328) ar not created. I have to do it by hand each start-up (written 
>>>into loacal.start.):
>>>mknod /dev/nvidia0 c 195 0
>>>mknod /dev/nvidiactl c 195 255
>>
>>Heh, and you expect me to be able to modify a binary driver to work with
>>udev how?  :)
>>
>>You're on your own here...
>>
> 
> 
> No offense, but you guys sometimes really see things as too black and
> white :)
> 
> Its only the high level api calls that are in binary object files, but
> the main interface to the kernel is source that needs compiling.  I have
> a patch attached here that adds basic sysfs support via the class_simple
> functions.

I just reemerged the nvidia-kernel which seems to incorporate your 
patcxh and yes, it works nicely. :-)

Prakash
