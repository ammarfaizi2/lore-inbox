Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282801AbSAEU3z>; Sat, 5 Jan 2002 15:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282861AbSAEU3o>; Sat, 5 Jan 2002 15:29:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6675 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282801AbSAEU30>; Sat, 5 Jan 2002 15:29:26 -0500
Message-ID: <3C376222.8090204@zytor.com>
Date: Sat, 05 Jan 2002 12:29:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.33.0201051833260.27113-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Sat, 5 Jan 2002, Albert D. Cahalan wrote:
> 
> 
>>Of course, /proc/bus/pci contains forbidden binary files.
>>You're supposed to be happy with ASCII text, as found in
>>the /proc/pci file.
>>
> 
> You miss the point. The point was that /proc/pci doesn't
> expose all of pci config space, whereas /proc/bus/pci does.
> The fact that it's binary instead of ascii is neither here nor there.
> 


... and if you want to see something that's worse than either, check out 
/proc/ide/hda/identify.  Converting binary to hex doesn't aid in display 
in any shape, way, or form; all it does is make it impossible to use 
"dd" to do what I want, or from using my own hexdump tool.

Binary has a place, and "ASCII for ASCIIs sake" is just stupidity.

	-hpa


