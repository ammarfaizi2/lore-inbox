Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAKVGq>; Thu, 11 Jan 2001 16:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbRAKVGg>; Thu, 11 Jan 2001 16:06:36 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:30008 "EHLO
	earth.su.valinux.com") by vger.kernel.org with ESMTP
	id <S129511AbRAKVG2>; Thu, 11 Jan 2001 16:06:28 -0500
Date: Thu, 11 Jan 2001 14:14:35 -0800
From: Dragan Stancevic <visitor@valinux.com>
To: Kambo Lohan <kambo77@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-eepro100@vger.kernel.org,
        infinity2@lock-net.com
Subject: Re: [eepro100] Ok, I'm fed up now
Message-ID: <20010111141435.C12616@valinux.com>
In-Reply-To: <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <LAW2-F8403oHMwVN7mi0000e9c6@hotmail.com>; from Kambo Lohan on Tue, Jan 09, 2001 at 11:45:49AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001, Kambo Lohan <kambo77@hotmail.com> wrote:
; I am having the same problems, I have duplicated the hard lockups / ethernet 
; hangs on two intel 815EE boards.  It happens when send traffic through the 
; onboard eepro100 is high, and sometimes running something like vmstat 1 in 
; the background triggers the lockup faster.  When it locks up there is 
; nothing in the log, no oops or anything.  Sometimes it just hangs eth0 with 
; the (cmd timeout) msgs and an ifconfig down/up fixes it temporarily.
; 


Kambo,

can you run the driver with a high debug flag and log what is going on,
make sure you have alot of space since it talks alot.

The card seems to be locking up with a couple of commands in the register that
are not known to me, my specs don't list them, hopefully the new specs talk
about it. At this time it's not known where the command comes from, I am
working on a patch that will tell a bit more about that...


-- 
I knew I was alone, I was scared, it was getting dark and
it was a hardware problem.

                                                -Dragan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
