Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVDCUXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVDCUXP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 16:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVDCUXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 16:23:15 -0400
Received: from av3-2-sn4.m-sp.skanova.net ([81.228.10.113]:8621 "EHLO
	av3-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261896AbVDCUXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 16:23:11 -0400
To: Jeremy Nickurak <atrus@rifetech.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Esben Stien <b0ef@esben-stien.name>,
       linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
	<87zmylaenr.fsf@quasar.esben-stien.name>
	<20050204195410.GA5279@ucw.cz>
	<873bvyfsvs.fsf@quasar.esben-stien.name>
	<87zmxil0g8.fsf@quasar.esben-stien.name>
	<1110056942.16541.4.camel@localhost>
	<87sm37vfre.fsf@quasar.esben-stien.name>
	<87wtsjtii6.fsf@quasar.esben-stien.name>
	<20050308205210.GA3986@ucw.cz> <1112083646.12986.3.camel@localhost>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Apr 2005 22:23:09 +0200
In-Reply-To: <1112083646.12986.3.camel@localhost>
Message-ID: <m34qen8v9u.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Nickurak <atrus@rifetech.com> writes:

> On Tue, 2005-03-08 at 21:52 +0100, Vojtech Pavlik wrote:
> > The problem is that the mouse really does reports all the double-button
> > stuff and autorepeat, and horizontal wheel together with button press on
> > wheel tilt.
> 
> Okay, I'm playing with this under 2.6.11.4 some more, and it really
> seems out of whack. The vertical cruise control buttons work properly,
> with the exception of the extra button press. But the horizontal buttons
> are mapping to 6/7 as non-repeat buttons, and adding simulateously the
> 4/5 events auto-repeated for as long as the button is down. That is to
> say, pressing the the horizontal scroll in a 2d scrolling area will
> scroll *diagonally* one step, then vertically until the button is
> released. 

Have you tried the Logitech mouse applet?

        http://freshmeat.net/projects/logitech_applet/

"logitech_applet --disable-cc" used to work for me when I owned an
MX1000 mouse.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
