Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWAJNeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWAJNeD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWAJNeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:34:03 -0500
Received: from gromit.trivadis.com ([193.73.126.130]:25168 "EHLO
	lttit.trivadis.com") by vger.kernel.org with ESMTP id S1750742AbWAJNeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:34:02 -0500
Message-ID: <43C3B7C8.8000708@cubic.ch>
Date: Tue, 10 Jan 2006 14:34:00 +0100
From: Tim Tassonis <timtas@cubic.ch>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
References: <43C3AAE2.1090900@cubic.ch> <20060110125357.GH3911@stusta.de>
In-Reply-To: <20060110125357.GH3911@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Jan 10, 2006 at 01:38:58PM +0100, Tim Tassonis wrote:
>> ...
>>> We can always undo mistakes later, but 
>>> we'll never get to that point if we don't start moving in one direction 
>>> instead of ten.
>> You were right if there were ten, but there seem to be only two at the 
>> moment. One stack will survive and one will die. There's no point in 
>> deciding this now.
> 
> No, we'll end up with two stacks, some drivers using the first stack and 
> some the second one.
> 
> You can't simply let one stack die because this would imply either 
> rewriting all drivers using this stack or dropping support for some 
> hardware.

By "die", I didn't mean "delete it from kernel sources".

It is very probable that over time, the "winning" stack will contain 
most drivers for the most common hardware, and the "losing" one just a 
few obscure ones. The "losing" one will still be available for people 
using hardware only supported by that stack.

Like the OSS/Alsa or XFree3.x/XFree4.x situations.

Tim


