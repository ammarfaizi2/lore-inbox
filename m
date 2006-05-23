Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWEWWlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWEWWlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWEWWlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:41:35 -0400
Received: from terminus.zytor.com ([192.83.249.54]:28096 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932255AbWEWWle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:41:34 -0400
Message-ID: <44738F99.3020108@zytor.com>
Date: Tue, 23 May 2006 15:41:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [-mm] klibc breaks my initscripts
References: <20060523083754.GA1586@elf.ucw.cz> <4473482A.3050407@zytor.com> <20060523211100.GA2788@elf.ucw.cz> <44737C33.4030503@zytor.com> <20060523215111.GA1669@elf.ucw.cz> <44738BA7.1020507@zytor.com> <20060523223652.GA1585@elf.ucw.cz>
In-Reply-To: <20060523223652.GA1585@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Aha, sorry for confusion. So it was not klibc merge but stricter
> parser to mount commandline. Problems are now fixed, thanks.
> 
> (And swsusp works okay; now I could test it from multiuser mode).
> 

Nice.  I'm still trying to set up an environment to verify the FC5 swsusp breakage fix 
(this was a bug in Red Hat's nash that pjones already sent me a patch for, I just haven't 
been able to test it yet due to my main machine blowing its chipset fan yesterday...)

	-hpa

