Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUEURIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUEURIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 13:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUEURIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 13:08:47 -0400
Received: from [141.156.69.115] ([141.156.69.115]:5799 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S265930AbUEURIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 13:08:45 -0400
Message-ID: <40AE379D.9090401@infosciences.com>
Date: Fri, 21 May 2004 13:08:45 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <Pine.LNX.4.44L0.0405211103350.651-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0405211103350.651-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Fri, 21 May 2004, nardelli wrote:
> 
> 
>>The api for usb_control_msg says, 'If successful, it returns 0, othwise a
>>negative error number', and I didn't see any other way to figure out how
>>much data was being returned.
> 
> 
> In the current kernel sources, the kerneldoc for usb_control_msg() says
> "If successful, it returns the number of bytes transferred, otherwise a 
> negative error number."
> 

Sorry, I was looking at dated api docs at kernelnewbies.org.  I'll use
the size returned from usb_control_msg() instead of memset().


-- 
Joe Nardelli
jnardelli@infosciences.com
