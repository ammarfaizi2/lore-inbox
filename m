Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280961AbRKORr0>; Thu, 15 Nov 2001 12:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280964AbRKORrU>; Thu, 15 Nov 2001 12:47:20 -0500
Received: from erasmus.jurri.net ([62.236.96.196]:35716 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S280931AbRKORpZ>; Thu, 15 Nov 2001 12:45:25 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: apm suspend broken ?
In-Reply-To: <E15yXjJ-0006Hr-00@the-village.bc.nu>
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: 15 Nov 2001 19:43:36 +0200
In-Reply-To: <E15yXjJ-0006Hr-00@the-village.bc.nu>
Message-ID: <87adxond4n.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> I, byt the way, had my Latitude suspend perfectly with 2.4.12-ac5. 
>> Now, with 2.4.13-ac[34] pressing Fn+Suspend just blanks the screen
>> (it doesn't shut it off, _just_ blanks it) and hangs the machine.
> Find exactly which -ac it broke in. If you do a binary search
> through a few patch levels you should be able to pin it down. At
> that point I can chase it

I didn't have time to do this earlier, but now:

It seems it broke with 2.4.12-ac4, which I believe updated APM
subsystem from 1.14 to 1.15.

Suonp‰‰...
