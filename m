Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131119AbRAHQvJ>; Mon, 8 Jan 2001 11:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130007AbRAHQu7>; Mon, 8 Jan 2001 11:50:59 -0500
Received: from web119.mail.yahoo.com ([205.180.60.120]:24581 "HELO
	web119.yahoomail.com") by vger.kernel.org with SMTP
	id <S131341AbRAHQuv>; Mon, 8 Jan 2001 11:50:51 -0500
Message-ID: <20010108165050.13240.qmail@web119.yahoomail.com>
Date: Mon, 8 Jan 2001 08:50:50 -0800 (PST)
From: Paul Powell <moloch16@yahoo.com>
Subject: 'console=' kernel parameter questions
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running an unmodified RedHat 6.2 kernel 
(kernel version 2.2.14-5.0)

I am trying to redirect the linux startup messages to
the serial port.  I've added the 'console=' parameter
to my lilo.conf file.  I've tried several iterations
such as
'console=ttys0','console=cua0','console=ttys0,9600n8',
etc....

They all fail to produce any output to the serial port
although they do remove the text from my screen.  When
I have booted RedHat I can type 'echo blah >
/dev/cua0' and I see text output from the serial port.
 Interestingly when I try to echo to /dev/ttys0 I get
an IO error message. I'm using a null modem cable
connect to a windows machine to watch the serial port.

My question: why can I see output when booted into
RedHat but not when booting the OS?  I've read that
you have to compile this feature into the kernel. 
Does anyone know if RedHat's kernel come with this
feature built in?

Your help appreciated,
Paul


__________________________________________________
Do You Yahoo!?
Yahoo! Photos - Share your holiday photos online!
http://photos.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
