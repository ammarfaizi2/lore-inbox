Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131414AbQK2NLI>; Wed, 29 Nov 2000 08:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131415AbQK2NLB>; Wed, 29 Nov 2000 08:11:01 -0500
Received: from meefw01.mee.com ([194.130.244.66]:39917 "HELO meefw01.mee.com")
        by vger.kernel.org with SMTP id <S131397AbQK2NKr>;
        Wed, 29 Nov 2000 08:10:47 -0500
Message-Id: <3A24F9C7.11F5D80D@vil.ite.mee.com>
Date: Wed, 29 Nov 2000 12:42:47 +0000
From: Wayne Price <Wayne.Price@vil.ite.mee.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3smp i686)
X-Accept-Language: en
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: W.Price@acropolis-solutions.co.uk
Subject: Question: Serial port device drivers...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to develop a device-driver to sit above the standard serial port -
in other
words, multiple processes can communicate with the driver which will translate
the
information into the required serial datastream for the device. (This could be
written
as a separate daemon-type process, I know, but as a kernel driver it will fit
into the
scheme of our system in a much neater way).

I haven't found any other drivers in the kernel which quite do what I want, and
I don't
particularly want to make a copy of the entire serial driver code and put the
mods into
that (seems like a waste of space). Essentially, what I need is to have a
relatively
simple driver which just calls the standard serial port routines to send/receive
data.

Has this been done before, and does anyone have any sample code or hints as to
what I
need to do? We are using kernel 2.2.16 (from RedHat-7.0).

Regards,

Wayne
________________________________________________________________________
Wayne Price   W.Price@acropolis-solutions.co.uk  Acropolis Solutions Ltd
Mobile: +44 (0) 7770 376383                    Home: +44 (0) 1483 531235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
