Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264225AbUEYNPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbUEYNPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264741AbUEYNPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:15:06 -0400
Received: from [141.156.69.115] ([141.156.69.115]:37046 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S264225AbUEYNPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:15:02 -0400
Message-ID: <40B346D6.6060908@infosciences.com>
Date: Tue, 25 May 2004 09:15:02 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com> <20040521223024.GA7399@kroah.com> <40B22EED.4080808@infosciences.com> <40B24F52.8050805@infosciences.com> <20040524200611.GC4558@kroah.com>
In-Reply-To: <20040524200611.GC4558@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, May 24, 2004 at 03:38:58PM -0400, nardelli wrote:
> 
>>nardelli wrote:
>>
>>1) Whether writing to the 1st or 2nd port, the machine hangs pretty badly
>>after catting /dev/urandom for more than 1 second or two.  This continues
>>even after catting has stopped, and the device has been disconnected.  This
>>smells like some type of resource leak, probably memory, to me.
> 
> 
> Which machine dies?  The pilot or the Linux box?
> 
> 

Oops - missed this question earlier.  It's the linux box that dies.  The
pilot makes it through without a scratch - I'm a bit shocked, as they're
not exactly the most stable device.


-- 
Joe Nardelli
jnardelli@infosciences.com
