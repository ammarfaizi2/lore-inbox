Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290290AbSAOVru>; Tue, 15 Jan 2002 16:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290295AbSAOVra>; Tue, 15 Jan 2002 16:47:30 -0500
Received: from mail.spylog.com ([194.67.35.220]:25837 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S290293AbSAOVrZ>;
	Tue, 15 Jan 2002 16:47:25 -0500
Date: Wed, 16 Jan 2002 00:49:10 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: http://www.spylog.ru
X-Priority: 3 (Normal)
Message-ID: <12051384657.20020116004910@spylog.ru>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re[2]: 3.5G user space speed
In-Reply-To: <3C44A224.120712C1@didntduck.org>
In-Reply-To: <16247691406.20020115234737@spylog.ru>
 <3C4499A3.781E5A85@didntduck.org> <15850171252.20020116002857@spylog.ru>
 <3C44A224.120712C1@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Brian,

Wednesday, January 16, 2002, 12:41:56 AM, you wrote:
>>
>> Well. May be you can tell about the numbers a bit ? I can chose 3.0G
>> for user instead of 3.5G for user with not really huge loss, but I'd
>> like to know how much it will increase speed and in which cases, also
>> about standard 2/2 mode.

BG> I don't have quantifiable numbers available, but the speed issue will be
BG> a result of the kernel running out of direct-mapped memory and having to
BG> start swapping even though there is free memory in the system (in the
BG> highmem zone).  The best thing you can do is try both and find what
BG> works best for you.

So how this should appear ? Like real swapping or like increased
system CPU usage because of moving pages to/from zone.


-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

