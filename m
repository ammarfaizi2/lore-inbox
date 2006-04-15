Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWDOJlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWDOJlf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 05:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWDOJlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 05:41:35 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:1988 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1751086AbWDOJle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 05:41:34 -0400
Message-ID: <4440C03F.4080709@keyaccess.nl>
Date: Sat, 15 Apr 2006 11:43:27 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
Subject: Re: Which device did I boot from?
References: <200604151059.47733.arvidjaar@mail.ru>
In-Reply-To: <200604151059.47733.arvidjaar@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:

>> If you choose the (experimental) CONFIG_EDD option in your kernel then,
>> with cooperation of your BIOS, you'll have a /sys/firmware/edd with at
>> least some info about the BIOS boot device. For me:
> 
> I am sorry but it does not tell about boot device. It contains all hard disks 
> enumerated via EDD interface. I do not see any information 
> under /sys/firmware/edd that would have allowed to guess boot device.

int13_dev80 is the bootdevice. Or that used to be the case with things 
such as booting from SCSI at least. Don't know about booting from, say, USB.

Rene.
