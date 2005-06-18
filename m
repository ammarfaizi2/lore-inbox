Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVFRPdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVFRPdK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 11:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVFRPdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 11:33:09 -0400
Received: from mail.linicks.net ([217.204.244.146]:19730 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262135AbVFRPcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 11:32:52 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Date: Sat, 18 Jun 2005 16:32:44 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181632.44467.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:

> On Saturday 18 June 2005 14:44, Nick Warne wrote:
>> >
>> > I had this problem because I was running an ancient version of udev
>> > (0.34, versus 0.58, at the time..). Try upgrading udev if it's out of
>> > date.
>>
>> Thanks, that worked :-)
>>
> 
> FWIW In the udev 058 announcement, Greg said:
> 
> "Note, if you are running a kernel newer than 2.6.12-rc4 (including the
> -mm releases) and you have any custom udev rules, you MUST upgrade to
> the latest version to allow udev to work properly.  This change happened
> because of a previously-unrealized reliance in libsysfs on the presence
> of a useless sysfs file that has recently been removed.  Hopefully the
> libsysfs people will be releasing a new version shortly with this change
> in it for those packages who rely on it."
> 
> Just a reminder because I bet many people will get caught out by this!

Yes - and also the download link on the main udev page is broke :-/

Here is where to get the latest udev build:

http://www.kernel.org/pub/linux/utils/kernel/hotplug/

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
