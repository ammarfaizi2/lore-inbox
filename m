Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287467AbSAPUbI>; Wed, 16 Jan 2002 15:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287464AbSAPUa6>; Wed, 16 Jan 2002 15:30:58 -0500
Received: from www.casdn.neu.edu ([155.33.251.101]:7951 "EHLO
	www.casdn.neu.edu") by vger.kernel.org with ESMTP
	id <S287471AbSAPUai>; Wed, 16 Jan 2002 15:30:38 -0500
From: "Andrew Scott" <A.J.Scott@casdn.neu.edu>
Organization: Northeastern University
To: Pascal Haakmat <a.haakmat@chello.nl>, linux-kernel@vger.kernel.org
Date: Wed, 16 Jan 2002 15:30:03 -0500
MIME-Version: 1.0
Subject: Re: Andre Hedrick's IDE patch saved my life
Reply-to: A.J.Scott@casdn.neu.edu
Message-ID: <3C459C7A.30004.EBDA61@localhost>
In-Reply-To: <20020112224005.A19577@awacs.dhs.org>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jan 2002 at 22:40, Pascal Haakmat wrote:

> Well, that's perhaps not entirely true, but they did solve the mysterious
> and funny, and not so funny, problems that I was having with Oopses and
> filesystem corruption (kernel 2.4.16, 2xPIII/600MHz, PIIX4, XFS).
> 
> Is there any reason at all why these patches are not part of the stock
> kernel? I mean the kernel just lost a disk of mine: is there any reason
> worth a disk of lost data?

Well, I've heard good things about the driver, but on one of my machines it 
fails to boot _if_ the Maxtor 34098H4 (40 G) drive is connected using an 80 
wire cable to an htp366 controller. If I use a 40 wire cable, it runs just 
fine. 

I have been through six 80 wire cables, just in case they were the problem. 
However, the controller, drive and any of the 80 wire cables work just fine 
on several other machines!

I do notice that the machine gets further into the boot than it used to. 
Previously it would stall when mounting / with a error about 'waiting for 
interrupt', I believe. Now mounts / but fails claiming a file that is being 
loaded is corrupt. Swap the cables, and it is able to read the previously 
'corrupted' file! 

I suspect that the issue is that the machine is quite old, an HP dual 
Pentium 200 (hp xu5/120, upgraded). It's memory speed is only about 25 MB/s, 
which is slower than udma4! :)





                      _
                     / \   / ascott@casdn.neu.edu
                    / \ \ /
                   /   \_/

