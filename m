Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751709AbWBELKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbWBELKR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWBELKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:10:16 -0500
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:3230 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S1751708AbWBELKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:10:15 -0500
Message-ID: <43E5DD0A.3030009@tremplin-utc.net>
Date: Sun, 05 Feb 2006 12:10:02 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.7-4mdk (X11/20051221)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: =?UTF-8?B?UGF3ZcKzIFphZHLCsWc=?= <p.zeddi@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] How to tune kernel to swap more often (video ram swap)
References: <b92f4fd10602050204g41f70f70p@mail.gmail.com>
In-Reply-To: <b92f4fd10602050204g41f70f70p@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-2.0.2 (reserv6.univ-lille1.fr [193.49.225.20]); Sun, 05 Feb 2006 12:10:08 +0100 (CET)
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05.02.2006 11:04, Paweł Zadrąg wrote/a écrit:
> Yo...
> 
> In normal case, using harddisk as a swap space i should ask how to cut
> down swapping, or make swapping when idle, etc... My case is a little
> bit diffrent... I have a 256MB video card, while 240MB of it is used
> as a swap space. And the question is: how to tune kernel to swap more
> often. I known swapped memory must be copied back to ram before beeing
> used, so i'm looking for a reasonable tunning values...
> 
> What do You think about that mighty list ?
Actually this list is not about Linux tuning. Please read post only 
about bugs and patches for the linux kernel.

Anyway, I guess what you are looking for is the "swappiness". For more 
info check 
http://www.brunolinux.com/06-Fine_Tuning_Your_System/Swappiness.html

Am I correctly understanding that you are using your video card memory 
as a place to put swap? This sounds quite cool, how have you done this? 
Is there a driver which can report the video ram as a block device?

see you,
Eric
