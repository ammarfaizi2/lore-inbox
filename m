Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266290AbRGDV0V>; Wed, 4 Jul 2001 17:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266554AbRGDV0K>; Wed, 4 Jul 2001 17:26:10 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:5126 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266290AbRGDVZ5>; Wed, 4 Jul 2001 17:25:57 -0400
Date: Wed, 4 Jul 2001 16:24:46 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: 2.4.6 keyspan driver
Message-ID: <20010704162446.A1943@glitch.snoozer.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010703103800.B28180@kroah.com> <20010703171953.A16664@glitch.snoozer.net> <20010703174950.A593@glitch.snoozer.net> <20010703191655.A1714@glitch.snoozer.net> <20010704003233.A30960@kroah.com> <20010704120404.A529@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010704120404.A529@glitch.snoozer.net>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.6 #1 Wed Jul 4 12:33:47 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something else which may or may not help... I hooked my modem up to the
Keyspan USA-19 adapter to see if that would make any difference.  pppd
wasn't able to dial out (no response from the modem), but the following
was logged during the attempt:

----- <SNIP> -----
Jul  4 16:13:50 glitch kernel: keyspan_usa19_calc_baud 9600 ff
b2.keyspan_usa28_send_setup already writingkeyspan_usa28_send_setup
already writingkeyspan_usa28_send_setup already
writingusa28_outcont_callback sending setupkeyspan_usa19_calc_baud 9600
ff b2.keyspan_usa19_calc_baud 9600 ff b2.keyspan_usa19_calc_baud 9600
ff b2.keyspan_usa19_calc_baud 9600 ff b2.usa28_indat_callbacknonzero
status: fffffffe on endpoint
----- <SNIP> -----
