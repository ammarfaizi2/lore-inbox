Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVADQrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVADQrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVADQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:47:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:7822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261708AbVADQnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:43:43 -0500
X-Authenticated: #884018
Message-ID: <41DAD6DA.70205@gmx.net>
Date: Tue, 04 Jan 2005 18:48:10 +0100
From: Till Kamppeter <till.kamppeter@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rene Rebe <rene@exactcode.de>
CC: George Garvey <tmwg-sane@inxservices.com>,
       sane-devel <sane-devel@lists.alioth.debian.org>,
       linux-kernel@vger.kernel.org, oliver@neukum.org, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com
Subject: Re: Please remove hpusbscsi Was: [sane-devel] HP 7450C, hpusbscsi,
 permissions in Fedora Core 3
References: <1104646290.5821.99.camel@localhost.localdomain> <20050102101258.GB8385@inxservices.com> <41D999CD.80105@exactcode.de>
In-Reply-To: <41D999CD.80105@exactcode.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have reported this to our Mandrakesoft kernel guys, so next 
Mandrakelinux version (10.2) should not have this problem any more.

http://qa.mandrakesoft.com/show_bug.cgi?id=12891

For now, simply remove or rename the module on your system.

    Till


Rene Rebe wrote:
> Hi,
> 
> we should remove hpusbscsi from the Kernel. It is long obsolete and very 
> unstable. I can send a patch for 2.4 and 2.6 (if needed) ;-)
> 
> George Garvey wrote:
> 
>> On Sat, Jan 01, 2005 at 10:11:30PM -0800, Thomas Frayne wrote:
> 
> 
> ...
> 
>>    As far as I know, Rene has made it pretty clear he doesn't want to
>> use hpusbscsi with the avision driver. He prefers libusb.
> 
> 
> Yes. Hpusbscsi has many drawbacks. The major ones are:
> 
>  - does not work with new scanners (that are designed for USB 2.0)
>  - it is highly instable (e.g. during an i/o error it locks up
>    quite easily and leaves the (usb sub-)system in a state that
>    needs a reboot ...
> 
> The later problem made me add the user-space i/o code to the 
> SANE/Avision backend, because I had to reboot my system every 5 minutes 
> during development ...
> 
> Yours,
> 

