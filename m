Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAPUD1>; Tue, 16 Jan 2001 15:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAPUDR>; Tue, 16 Jan 2001 15:03:17 -0500
Received: from pop.gmx.net ([194.221.183.20]:24963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129534AbRAPUDA>;
	Tue, 16 Jan 2001 15:03:00 -0500
Message-ID: <3A64A5D7.5020801@gmx.de>
Date: Tue, 16 Jan 2001 20:49:43 +0100
From: Ronny Buchmann <rbla@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17 i686; de-AT; 0.7) Gecko/20010105
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug (isdn-subsystem?) in 2.4.0
In-Reply-To: <Pine.LNX.4.30.0101152306480.2419-100000@vaio>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kai Germaschewski wrote:

> On Mon, 15 Jan 2001, Ronny Buchmann wrote:
> 
> 
>> i have the following problem with kernel 2.4.0 (also with -ac6):
>> 
>> kernel BUG at slab.c:1095!
>> invalid operand: 0000
>> CPU: 0
> 
> 
> I could reproduce the problem, the appended patch fixes it here. Linus,
> could you please apply this for 2.4.1?
but a part of the problem remains: i can't get a succesful connection

the calling side gets a CONNECT message, but on the called side i only 
get the RING
and after some seconds on both lines NO CARRIER

syslog only shows the RING and no connect

the same when i'm calling from gsm phone

btw, when calling from mobile phone i have to leave S19=197 (with 2.2.17 
S19=0 is working as described in the isdn faq, has this changed now?)

>> (if you need the other numbers or anything else, ask me, i can reproduce
>> it easily)
> 
> 
> A decoded oops would be nice the next time, see
> 
> 	<your linux kernel source>/REPORTING-BUGS
> 
sorry, my fault

tia
ronny

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
