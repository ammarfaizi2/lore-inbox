Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVAZOVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVAZOVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVAZOVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:21:02 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:29059 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S262307AbVAZOU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:20:59 -0500
Date: Wed, 26 Jan 2005 15:20:54 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Shawn Starr <shawn.starr@rogers.com>, Greg KH <greg@kroah.com>,
       Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2] I2C: lm80 driver improvement (From Aurelien)
Message-ID: <20050126142054.GC23182@speedy.student.utwente.nl>
Mail-Followup-To: Shawn Starr <shawn.starr@rogers.com>,
	Greg KH <greg@kroah.com>, Aurelien Jarno <aurelien@aurel32.net>,
	linux-kernel@vger.kernel.org
References: <200501260249.23583.shawn.starr@rogers.com> <20050126140509.GB23182@speedy.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126140509.GB23182@speedy.student.utwente.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 03:05:09PM +0100, I wrote:
> BTW, can anyone tell me why the uints in this parameter list are declared as
> 'unsigned' and not as 'unsigned int'?
$ find /usr/src/linux/ -name \*.c |xargs grep unsigned\ [^icsl] |wc -l
3151

- Gives himself a good smack on the head -

Sorry about that. I suppose it's just used a lot as a shorthand for 'unsigned
int', which is used a lot more in the kernel (the above command finds 22656
occurrences). On a sidenote, however, wouldn't it be nice for things like this
to be consistent throughout the kernel? Don't think I have an opinion on this,
because I don't, but I'd like to see those of the ones who do.

    Sytse
