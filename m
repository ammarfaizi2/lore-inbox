Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUDJQy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 12:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUDJQy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 12:54:26 -0400
Received: from ns.clanhk.org ([69.93.101.154]:36531 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262062AbUDJQyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 12:54:25 -0400
Message-ID: <407826DF.9030506@clanhk.org>
Date: Sat, 10 Apr 2004 11:54:55 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd64 questions
References: <1Ijzw-4ff-5@gated-at.bofh.it> <1Ijzv-4ff-3@gated-at.bofh.it>	<1IntE-7wn-39@gated-at.bofh.it> <m3isgb69xx.fsf@averell.firstfloor.org>
In-Reply-To: <m3isgb69xx.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>It is a subsystem bug really. These subsystems were all designed to
>not require emulation, but the designers weren't aware of all the
>requirements for this and broke it for AMD64/IA64. Unfortunately the
>interfaces were done in a way that it would be very complicated and a
>lot of work to write an emulation layer, because they're extremly
>emulation unfriendly. Maybe it would be still possible to write an
>emulation layer, but easier is it to just use static 64bit executables 
>or hacked 32bit executables.
>
>I don't have any plans to write emulation layers for such hopeless
>cases on my own, but just declared these subsystems as broken.
>  
>
So let me get this straight, we can't use LVM with AMD64 under the 2.6 
line either?  Or we can if we use AMD64 [DM] libraries with a AMD64 
kernel?  DM = Device Mapper right?

-ryan
