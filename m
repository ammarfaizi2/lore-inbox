Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbUC3OeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUC3OeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:34:15 -0500
Received: from tristate.vision.ee ([194.204.30.144]:42372 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S263682AbUC3OeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:34:11 -0500
Message-ID: <40698562.9090300@vision.ee>
Date: Tue, 30 Mar 2004 17:34:10 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040321)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc3
References: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>	 <40690B84.7060203@cornell.edu> <200403300814.21205.dominik.karall@gmx.net>	 <200403301026.09039@WOLK> <1080650274.1134.0.camel@teapot.felipe-alfaro.com> <40697F1F.5050003@cornell.edu>
In-Reply-To: <40697F1F.5050003@cornell.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Gyurdiev wrote:

>>
>> What about CONFIG_REGPARM? Did you enable it?
>
>
> No, it's off...
> I'll do some more testing and figure out which changeset breaks it.

Whatever is the cause it might have come from -mm tree.
I remember than 2.6.5-rc2 worked with 5336nvidia, but when I applied
-mm2 it started to hang after X start or just made spontaneous reboot.

In case of -mm2 I'm almost sure 4KSTACK wasn't enabled, but can't check 
right now.
MREGPARM wasn't - that's sure.

Lenar

