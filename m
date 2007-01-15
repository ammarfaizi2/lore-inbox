Return-Path: <linux-kernel-owner+w=401wt.eu-S1751734AbXAOABd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXAOABd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbXAOABd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:01:33 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:46786 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbXAOABc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:01:32 -0500
Message-ID: <45AAC44D.808@citd.de>
Date: Mon, 15 Jan 2007 01:01:17 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Richard Knutsson <ricknu-0@student.ltu.se>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
References: <45A9092F.7060503@student.ltu.se> <45A93B02.7040301@citd.de> <45A96E31.3080307@student.ltu.se> <45A973A8.1000101@citd.de> <45AAA3C2.80603@student.ltu.se> <tkrat.b40f8fe0936d84cd@s5r6.in-berlin.de>
In-Reply-To: <tkrat.b40f8fe0936d84cd@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> On 14 Jan, Richard Knutsson wrote:
> 
>>(Really liked the idea to have a "Maintainer"-button 
>>next to "Help" in *config)
> 
> 
> Rhetorical question: What will this button be used for?

Having "all(tm)" information of something in one place?
Help-Text and Dependencies/Selects are already there.
I think adding the Maintainers-data is more or less a logical next step.

It's not always clear from the MAINTAINERS-file who is the right person
for what. Especially as it is a rather large text-file with only
mediocre search-friendlieness. It's a 3.5 K-lines file!

So when you know that you have a problem with drivers X, wouldn't it be
great if you could just "go to" the driver in *config and see not only
the Help-Text but the Maintainers-Data also.
And you can place "Fallback"-Maintainers-Data on Tree-Parents, for the
cases where you only can pinpoint a area, like when you have a problem
with a USB-device.


I can ask a rhetorical question too:
Why not go back to Config.help. Having a huge X K-Lines file with
everything in one file can't be that bad. It worked before!




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

