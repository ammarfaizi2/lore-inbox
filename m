Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSLQOcu>; Tue, 17 Dec 2002 09:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSLQOcu>; Tue, 17 Dec 2002 09:32:50 -0500
Received: from zork.zork.net ([66.92.188.166]:62159 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S265097AbSLQOct>;
	Tue, 17 Dec 2002 09:32:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: How to get the size of the block device ???? (Important)
References: <Pine.LNX.3.95.1021217093512.24416A-100000@chaos.analogic.com>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DICTO SIMPLICITER, PROMOTION OF SELF
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Tue, 17 Dec 2002 14:40:47 +0000
In-Reply-To: <Pine.LNX.3.95.1021217093512.24416A-100000@chaos.analogic.com> ("Richard
 B. Johnson"'s message of "Tue, 17 Dec 2002 09:36:26 -0500 (EST)")
Message-ID: <6ud6o0so7k.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Richard B. Johnson quotation:

> On Tue, 17 Dec 2002, [iso-8859-1] Sanjay Kumar wrote:
>
>> Problem Summary : I need the size of the block device in bytes on
>> which my file system will be created.  Actually, there is a feild
>> in the super block, needs the total no of blocks on the device
>> while while creating the filesystem. So, Can you Plz. help me out
>> of this problem.
>
> You make an ioctl() function for your file-system that returns the
> block-size that you selected when you designed the system.

The size of the block device is what is sought here, not the block
size of the filesystem.

Isn't there an ioctl for this?  BLKSIZEGET or something?

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
