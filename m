Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265889AbSKBH3g>; Sat, 2 Nov 2002 02:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265892AbSKBH3g>; Sat, 2 Nov 2002 02:29:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:62223 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265889AbSKBH3g>;
	Sat, 2 Nov 2002 02:29:36 -0500
Date: Sat, 2 Nov 2002 08:34:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fatal error: ... template
Message-ID: <20021102073410.GA1730@mars.ravnborg.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211011326200.5079-100000@oddball.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211011326200.5079-100000@oddball.prodigy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 01:34:25PM -0500, Bill Davidsen wrote:
> sh arch/i386/boot/install.sh 2.5.44-ac5 arch/i386/boot/bzImage System.map ""
> fatal error: unable to find a suitable template
> oddball:root> exit
> exit
install.sh contains the following lines:

if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi

So you should look in the distribution specific installkernel files.
I do not see anything in install.sh that could result in the error above.

	Sam
