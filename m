Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbULKRbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbULKRbY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbULKRbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:31:24 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:24736
	"HELO fargo") by vger.kernel.org with SMTP id S261976AbULKRbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:31:19 -0500
Date: Sat, 11 Dec 2004 18:30:32 +0100
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Simos Xenitellis <simos74@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Improved console UTF-8 support for the Linux kernel?
Message-ID: <20041211173032.GA13208@fargo>
Mail-Followup-To: Simos Xenitellis <simos74@gmx.net>,
	linux-kernel@vger.kernel.org
References: <1102784797.4410.8.camel@kl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1102784797.4410.8.camel@kl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon ;),

> The current UTF-8 keyboard input (for the console) of the Linux kernel
> does not support  "composing" or writing characters with accents.

Yes, i recently find it out when trying to switch all my system to
UTF-8. But the patch from Chris you mention below works very well
for me (and for anybody that needs to type compose characters for
languages based in the latin1 encoding i guess).

> affects quite a few languages that require accents (French, German,
> Danish, Swedish?, Greek, cyrillic-based?, others?.). 

Spanish ;))

> Chris Heath has a set of incremental patches
> (http://chris.heathens.co.nz/linux/utf8.html) to enhance Unicode for the
> console.
> I noticed that he contacted this list in May 2003
> (http://seclists.org/lists/linux-kernel/2003/May/7956.html) but
> unfortunatelly the discussion was diverted to coding styles.

Chris told me in the utf-8 mailing list that he doesn't think his patch to
make the kernel generate UTF-8 characters in the compose tables will be
included in the main kernel. Basically because is not a full solution that
cover all the cases... But there is nothing better, so maybe it will be a
good idea to include it. Current state is, for 2.6 kernel, text console
is broken in UTF-8 mode because it cannot generate UTF-8 composed characters.

> Is there an interest for re-submission of mentioned patches for
> inclusion in the kernel (yeah, provided coding style is "normalised")?

At least, I am _really_ interested :)

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
