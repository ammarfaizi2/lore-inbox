Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbRG3TjY>; Mon, 30 Jul 2001 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbRG3TjO>; Mon, 30 Jul 2001 15:39:14 -0400
Received: from atlrel7.hp.com ([192.151.27.9]:55310 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S267632AbRG3TjA>;
	Mon, 30 Jul 2001 15:39:00 -0400
Message-ID: <3B65B7EC.42245D62@fc.hp.com>
Date: Mon, 30 Jul 2001 13:39:24 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <Pine.LNX.4.33L.0107301520040.5582-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel wrote:
> 
> On Thu, 26 Jul 2001, Khalid Aziz wrote:
> 
> > serial console. The bummer is this table was designed by Microsoft and
> > Microsoft owns the copyright on it. Microsoft primarily designed this
> 
> Microsoft owns the copyright on that particular document.
> 
> If I were to give you an mp3 with descriptions of what
> various bits to poke at you'd be free to do whatever you
> want with that info ;)
> 
> In fact, I suspect you're already free to do whatever
> you want with the info contained in the document...
> 

You are possibly right. It would be better to use SPCR as opposed to
another equivalent table since every vendor is extremely likely to
include SPCR in their ACPI implementation in the firmware since
Microsoft would require it, which may not be the case with another
table. If everyone feels there is no problem with using SPCR as it is,
then I can release the code I have already done to support it. One thing
I should point out is since Microsoft owns the definition for SPCR (same
applies to DBGP which defines a Debug serial port), they can easily
change the defitnition of the table and Linux will have to play catch
up, although that situation would be nothing new. 

Here is an excerpt from the disclaimer in the table description document
for anyone interested:

"Disclaimer: The information contained in this document represents the
current view of Microsoft Corporation on the issues discussed as of  the
date of publication. Because Microsoft must respond to changing market
conditions, it should not be interpreted to be a commitment on  the part
of Microsoft, and Microsoft cannot guarantee the accuracy of any
information presented. This document is for informational purposes only.
MICROSOFT MAKES NO WARRANTIES, EXPRESS OR IMPLIED, IN THIS DOCUMENT.

Microsoft Corporation may have patents or pending patent applications,
trademarks, copyrights, or other intellectual property rights covering
subject matter in this document. The furnishing of this document does
not give you any license to the patents, trademarks,  copyrights, or
other intellectual property rights except as expressly provided in any
written license agreement from Microsoft Corporation.  

Microsoft does not make any representation or warranty regarding
specifications in this document or any product or item developed based
on these specifications. Microsoft disclaims all express and implied
warranties, including but not  limited to the implied warranties or
merchantability, fitness for a particular purpose and freedom from
infringement. Without limiting the generality of the foregoing,
Microsoft  does not make any warranty of any kind that any item
developed based on these  specifications, or any portion of a
specification, will not  infringe any copyright, patent, trade secret or
other intellectual property right of any person or entity in any
country. It is your responsibility  to seek licenses for such
intellectual property  rights where appropriate. Microsoft shall not be
liable for any damages arising out of or in  connection with the use of
these specifications, including liability for lost profit, business
interruption, or any other damages whatsoever."



-- 
====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
