Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbTLZX6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbTLZX6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:58:33 -0500
Received: from ms-smtp-01-qfe0.nyroc.rr.com ([24.24.2.55]:48625 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S265276AbTLZX5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:57:14 -0500
Message-ID: <3FECCAF9.7070209@maine.rr.com>
Date: Fri, 26 Dec 2003 18:57:45 -0500
From: "David B. Stevens" <dsteven3@maine.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Jos Hulzink <josh@stack.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.7 (future kernel) wish
References: <200312232342.17532.josh@stack.nl> <20031226233855.GA476@hh.idb.hist.no>
In-Reply-To: <20031226233855.GA476@hh.idb.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I agree that the kernel should provide decent error handling and 
reporting I still have to ask questions about what is reasonable.

What does that other OS do when you pull a USB stick out?  What do you 
think the kernel should do?  Why don't the applications operating on the 
data take better care of handling error conditions?

I don't have one here to try, but at some point the (ab)user needs to 
take a bit of the heat for his or her action(s) or lack thereof.

After all you could just reach in your case and rip out the IDE or SCSI 
cables.  Bet that leads to all kinds of stuff (tm).

Cheers,
  Dave


Helge Hafting wrote:

>On Tue, Dec 23, 2003 at 11:42:17PM +0100, Jos Hulzink wrote:
>  
>
>>Hi,
>>
>>First of all... Compliments about 2.6.0. It is a superb kernel, with very few 
>>serious bugs, and for me it runs stable like a rock from the very first 
>>moment.
>>
>>As an end user, Linux doesn't give me a good feeling on one particular item 
>>yet: Error handling. 
>>
>>What do I mean ? Well... for example: Pull out your USB stick with a mounted 
>>fs on it. 
>>    
>>
>
>You aren't supposed to do that.  If you want to pull devices like that,
>with no warning, access them in other ways than mounting.  
>mtools are nice when you don't want to mount/umount floppies - a
>similiar approach should work for usb sticks too.
>
>
>
>Helge Hafting
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


