Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRAIXJ5>; Tue, 9 Jan 2001 18:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132554AbRAIXJv>; Tue, 9 Jan 2001 18:09:51 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:26621 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S132551AbRAIXJh>; Tue, 9 Jan 2001 18:09:37 -0500
Date: Tue, 9 Jan 2001 15:09:30 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Paul Powell <moloch16@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'console=' kernel parameter questions
In-Reply-To: <20010108165050.13240.qmail@web119.yahoomail.com>
Message-ID: <Pine.LNX.4.21.0101091508570.20058-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

append="console=/dev/ttyS0"

that should do the trick

enjoy
-kelsery

On Mon, 8 Jan 2001, Paul Powell wrote:

> Hello,
> 
> I am running an unmodified RedHat 6.2 kernel 
> (kernel version 2.2.14-5.0)
> 
> I am trying to redirect the linux startup messages to
> the serial port.  I've added the 'console=' parameter
> to my lilo.conf file.  I've tried several iterations
> such as
> 'console=ttys0','console=cua0','console=ttys0,9600n8',
> etc....
> 
> They all fail to produce any output to the serial port
> although they do remove the text from my screen.  When
> I have booted RedHat I can type 'echo blah >
> /dev/cua0' and I see text output from the serial port.
>  Interestingly when I try to echo to /dev/ttys0 I get
> an IO error message. I'm using a null modem cable
> connect to a windows machine to watch the serial port.
> 
> My question: why can I see output when booted into
> RedHat but not when booting the OS?  I've read that
> you have to compile this feature into the kernel. 
> Does anyone know if RedHat's kernel come with this
> feature built in?
> 
> Your help appreciated,
> Paul
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Photos - Share your holiday photos online!
> http://photos.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
