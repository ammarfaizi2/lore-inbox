Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSKYTWp>; Mon, 25 Nov 2002 14:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSKYTWp>; Mon, 25 Nov 2002 14:22:45 -0500
Received: from mail.wincom.net ([209.216.129.3]:16401 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S265508AbSKYTWn>;
	Mon, 25 Nov 2002 14:22:43 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Nov 2002 14:30:15 -0500
Subject: Re: A Kernel Configuration Tale of Woe
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3de27d7d.59a8.0@wincom.net>
X-User-Info: 129.9.27.145
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Richard B. Johnson wrote:

>> This is the linux-kernel list. Nothing you said has anything
>> to do with the linux-kernel. 

Oh really Richard?

Re-read the message. 

Point #1 has to do with kernel configuration; ie, "cd /usr/src/linux ; make
xconfig" and the choices made thereafter. I want something like "make modelnumberconfig"
that abstracts away most of the lower level items based on what low-level stuff
is associated with which chunk of hardware.*

I'm pretty sure any time you're invoking the kernel Makefile that you're discussing
a "linux kernel issue"

Point #2 has to do with the messages that drivers, modules, and other bits of
kernel code print to the dmesg data store wrt how they are currently set up
- in other words, kernel state information. The last time I checked, these messages
were contained inside the kernel source - I remember looking through "ide.c"
looking to see what the "idebus=xx" parameter really controlled, and if it had
anything to do with the ATAxx values (as it turns out, it does not, although
my Googling indicates that this seems to be a common misconception)

So this, as well, is entirely appropriate material for linux-kernel.

Point #3 has to do with the issues in publishing where what hardware is supported
in what kernel version, and where drivers not currently contained in the vanilla
kernel are located. Put another way, point #3 is about locating the output of
the work of people "employed" on linux-kernel, and so is also entirely appropriate.


That you are knee-jerk flaming a legitimate message that is entirely on-topic
indicates that you didn't actually read the message, and instead fixated on
one or two statements contained within itand made assumptions from there. That
doesn't seem like good kernel developer practice - perhaps you were looking
for Slashdot?

-------------
* I saw one response from a gentleman who indicated that the low-level hardware
associated with a given "high-level" part number may well change during the
life of the part, and that this poses difficulty. I agree. I also think that
"perfect is the enemy of good enough" and that a case where you can abstract
away the underlying complexity for 90% of the people is probably good enough;
especially if there is some sort of feedback mechanism whereby running changes
to "high level" part numbers (and the related "low-level" kernel module associations)
can be updated in short order.

For the gentleman who posted examples of ATA dmesg output that duplicated very
nearly what I was asking for, mine didn't do that. I'll take that (very specific)
issue up in a later thread when I have access to the dmesg output from my machine.


DG
