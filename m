Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281307AbRKPLa2>; Fri, 16 Nov 2001 06:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281309AbRKPLaS>; Fri, 16 Nov 2001 06:30:18 -0500
Received: from [195.63.194.11] ([195.63.194.11]:53521 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281307AbRKPLaK>; Fri, 16 Nov 2001 06:30:10 -0500
Message-ID: <3BF4F6A6.10163203@evision-ventures.com>
Date: Fri, 16 Nov 2001 12:21:10 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: __get_free_pages but no get_free_pages?
In-Reply-To: <20011115233528.A7496@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> free_pages() exists.
> __get_free_pages() exists.
> get_free_pages() does not. Why? What's the reason get_free_pages
> always has two underscores at the beggining?

That's purposedly so to discourage the usage of it, since this
function should be considered as an "implementation detail" I think.

> --
> STOP THE WAR! Someone killed innocent Americans. That does not give
> U.S. right to kill people in Afganistan.

That where not just Americans who died there.
The best way to stop a war is sometimes just to win it fast.
