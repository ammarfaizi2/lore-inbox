Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbSJaSGP>; Thu, 31 Oct 2002 13:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbSJaSF1>; Thu, 31 Oct 2002 13:05:27 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:55430 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S262712AbSJaSEo>; Thu, 31 Oct 2002 13:04:44 -0500
Message-ID: <3DC171FF.5000803@nortelnetworks.com>
Date: Thu, 31 Oct 2002 13:10:07 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 	In particular when it comes to this project, I'm told about
> 	"netdump", which doesn't try to dump to a disk, but over the net.
> 	And quite frankly, my immediate reaction is to say "Hell, I
> 	_never_ want the dump touching my disk, but over the network
> 	sounds like a great idea".
> 
> To me this says "LKCD is stupid". Which means that I'm not going to apply 
> it, and I'm going to need some real reason to do so - ie being proven 
> wrong in the field.

How do you deal with netdump when your network driver is what caused the 
crash?

Ideally I would like to see a dump framework that can have a number of 
possible dump targets.  We should be able to dump to any combination of 
network, serial, disk, flash, unused ram that isn't wiped over restarts, 
etc...

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

