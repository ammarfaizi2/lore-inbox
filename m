Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVHOSbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVHOSbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVHOSbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:31:07 -0400
Received: from mail.linicks.net ([217.204.244.146]:57615 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S964893AbVHOSbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:31:05 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE CD problems in 2.6.13rc6
Date: Mon, 15 Aug 2005 19:30:53 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151930.53613.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:
 
> On 2005-08-14 20:10:49 Nick Warne wrote:
> 
>>Note the last sentence:
>>
>>' This  variation  is  designed for use with "libraries" of drive
>>identification information, and can also be used on ATAPI drives which may
>>give  media errors with the standard mechanism.
> 
> My jaw just clonked on the table. And the media error at hand made you
> buy a new CD-RW. There is precedence for this (remember the blaming X and
> other programs in the keyboard driver?) 

Just for the record, it was a KDE service daemon that caused these errors for 
me, like a 24MB log in 12 hours:

KDED Media Manager

Also trying to remember, I had a CD-RW on /dev/hdc and a CD-R on /dev/hdd.  It 
was /dev/hdd that give those errors, but I only passed the SCSI emulation on 
kernel line for the CD-RW.

So I suppose it uses similar code (of sorts) as HDPARM.  I dunno.

The old drive was 6 years old anyway - so after I sussed the issue I pretend I 
did an upgrade ;-)

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
