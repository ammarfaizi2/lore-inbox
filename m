Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTLCXWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTLCXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:22:41 -0500
Received: from bay7-f45.bay7.hotmail.com ([64.4.11.45]:9481 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262352AbTLCXWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:22:36 -0500
X-Originating-IP: [63.144.164.60]
X-Originating-Email: [jason_kingsland@hotmail.com]
From: "Jason Kingsland" <jason_kingsland@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: KendallB@scitechsoft.com
Subject: RE: Linux GPL and binary module exception clause?
Date: Wed, 03 Dec 2003 23:22:34 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F45ru3EAVZ3l6q00008766@hotmail.com>
X-OriginalArrivalTime: 03 Dec 2003 23:22:34.0661 (UTC) FILETIME=[550D7550:01C3B9F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:
>So does this exception clause exist or not? If not, how can the binary 
>modules be valid for use under Linux if the source is not made available 
>under the terms of the GNU GPL?


The exception does not exist, at least not as a clearly stated license 
ammendment or similar.

There was some email discussion on this topic with input from the various 
Linux contributors some time back, but no firm conclusion. It's archived 
here: http://people.redhat.com/rkeech/pkm.html

This led indirectly to the introduction of the GPL license flag for kernel 
API calls, so that authors who specifically don't want their code used by 
binary modules can mark it as such.

By inference, this essentially provided a defendable position that binary 
loadable modules are OK so long as they don't use API calls explicitly 
defined as GPL only. Otherwise why else would such a flag have been 
introduced?

Many vendors use this as an excuse not to release their software under GPL.  
They are distributing GPL derived works in a binary-only format and are in 
violation of the Linux kernel copyright as far as I am aware.

This doesn't make it any more legal - but I suspect that it's a case of risk 
assessment on a case by case basis.

One assessment could be that the Linux authors are not likely to sue for 
copyright violation because they'll never get together and agree to enforece 
the GPL in this scenario, due to such differing opinions.

There are many instances of companies either ignoring the GPL license for 
their Linux-derived products, or at least not providing source for kernel 
modules they develop to support their proprietary hardware.

Just look at where Linux is embedded it consumer electronics (cellphones, 
DVD players etc) and how many of those are shipped with GPL license, source 
code or the required offer of source code.

>From time when a GPL violation is brought out into the open on Slahsdot, 
this mailing list or elsewhere. There is never any concerted effort by Linux 
authors to defend the copyright and insist on GPL compliance.

Part of the problem is that for Linux, copyright is not assigned back to any 
one person or entity therefore it's more difficult for any individual to try 
and 'fight the cause' of GPL compliance. Another problem is that Linux is 
global, and many of the binary-only vendors are in the far-east where the 
culture is perhaps less concerned about copyright law, US or otherwise.

So it seems that there is nothing do loose, anyone can take Linux and do 
whatever they please with it and not have to be particularly worried about 
contributing back to the community or complying with the rules of the 
commons, because nobody is likely to enforce the requirements against them.

_________________________________________________________________
Express yourself with cool emoticons - download MSN Messenger today! 
http://www.msn.co.uk/messenger

