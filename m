Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266326AbUA2ToH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266328AbUA2ToG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:44:06 -0500
Received: from lanshark.nersc.gov ([128.55.16.114]:13697 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S266326AbUA2TnJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:43:09 -0500
Message-ID: <401960BB.2070803@lbl.gov>
Date: Thu, 29 Jan 2004 11:36:27 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Can't boot a 2.6 kernel..
References: <40195C71.8080608@lbl.gov> <20040129193251.GA31524@bitwizard.nl>
In-Reply-To: <20040129193251.GA31524@bitwizard.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Thu, Jan 29, 2004 at 11:18:09AM -0800, Thomas Davis wrote:
> 
>>Ok, I'm trying to get a 2.6 kernel to boot on my desktop here at work.
>>
>>I have tried 3 different kernels - 2.6.1, 2.6.2rc1, and arjanv's 2.6.1 
>>kernel.
>>
>>After the grub prompt, I get the grub kernel description, and then..
>>
>>Nothing. Nada. Zip. Zilch.
>>
>>2.4 kernels boot and works fine; I've attached the dmesg output of one of 
>>it's boots.
>>
>>Any ideas on what to try?
> 
> 
> I hope you read the post-halloween document, especially the part about
> "Known gotchas"? See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt
> 

Not it.

[root@lanshark linux-2.6.1]# egrep CONFIG_VGA\|CONFIG_INPUT\|CONFIG_VGA_CONSOLE\|CONFIG_VT_CONSOLE .config
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_INPUT_JOYDUMP=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m
CONFIG_VT_CONSOLE=y
CONFIG_VGA_CONSOLE=y

