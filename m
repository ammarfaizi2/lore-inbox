Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932809AbWJINdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809AbWJINdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbWJINdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:33:23 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:58789 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932809AbWJINdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:33:22 -0400
Message-ID: <452A4FA1.10701@s5r6.in-berlin.de>
Date: Mon, 09 Oct 2006 15:33:21 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Pavel Machek <pavel@ucw.cz>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 V9] drivers: add LCD support
References: <20061006002950.49b25189.maxextreme@gmail.com>	 <20061008182438.GA4033@ucw.cz>	 <653402b90610081137g7885fc85h54e5e94de682a246@mail.gmail.com>	 <20061008191217.GA3788@elf.ucw.cz>	 <653402b90610081312m32fcf7ecx9929ae9dc4768c17@mail.gmail.com>	 <20061008211550.GE4152@elf.ucw.cz>	 <653402b90610081436w34d692ecv2dd9801c451ab490@mail.gmail.com>	 <20061008220722.GG4152@elf.ucw.cz> <653402b90610081545n51cdfbcej469990279f6d018c@mail.gmail.com>
In-Reply-To: <653402b90610081545n51cdfbcej469990279f6d018c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/2006 12:45 AM, Miguel Ojeda wrote:
> On 10/9/06, Pavel Machek <pavel@ucw.cz> wrote:
...
>> What is advantage of /dev/cfag12864bX over /dev/fbcfag12864b ?
>>
>> (And I guess you should invent better name... /dev/fbaux0?)

If the driver exposes sensible information, udev can give names.

...
>> I do not think it is suitable for -rc at this point, and it does not
>> have chance before 2.6.20-rc1, anyway.
> 
> No? Why not? Time is not a problem, I would want to know why are you
> saying that.

Linus currently has a rule for merge windows; akpm certainly doesn't.

On 10/8/2006 11:36 PM, Miguel Ojeda wrote:
||| I have no problem coding the fbcfag12864b module in my free time;
||| but I prefer to remain the other modules as they are now and add
||| the fbcfag12864b later in time: I'm waiting them to get into one
||| of the -rcs without more radical changes.

An interface which promises to be future-proof, especially if it is an
interface to userspace, is of course a requirement to get into mainline
in the first place. (However I don't know enough about the interfaces
discussed here nor about your requirements to say anything specifically
about your interface or the one Pavel suggested.)
-- 
Stefan Richter
-=====-=-==- =-=- -=---
http://arcgraph.de/sr/
