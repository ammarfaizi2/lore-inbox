Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVCEM4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVCEM4o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 07:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVCEM4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 07:56:44 -0500
Received: from mail48-s.fg.online.no ([148.122.161.48]:35733 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S262536AbVCEM42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 07:56:28 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
	<87zmylaenr.fsf@quasar.esben-stien.name>
	<20050204195410.GA5279@ucw.cz> <1108105875.5676.3.camel@localhost>
	<87vf8uee2q.fsf@quasar.esben-stien.name>
	<1108440859.26172.1.camel@localhost>
	<87psz1fv8c.fsf@quasar.esben-stien.name>
	<1108537815.32143.12.camel@localhost>
From: Esben Stien <b0ef@esben-stien.name>
X-Home-Page: http://www.esben-stien.name
Date: Sat, 05 Mar 2005 13:56:11 +0100
In-Reply-To: <1108537815.32143.12.camel@localhost> (Jeremy Nickurak's
 message of "Wed, 16 Feb 2005 00:10:15 -0700")
Message-ID: <87y8d2l09g.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Nickurak <atrus@rifetech.com> writes:

> A custom rule in /etc/udev/rules.d/00_logitech.rules:

Nice.

> Just like programs interpret buttons 4 and 5 as vertical scrolling,
> they interpret 6 and 7 as the horizontal scrollers. GTK, mozilla,
> galeon, and firefox all go by this principal

Hmm, where is this defined in firefox?. It would be logical to assume that the side buttons for going back and forth would be 6/7 as the 

> (Mozilla/galeon/firefox use the horizontal scroll for
> backward/foreward by default. You can change this by setting
> mousewheel.horizscroll.withnokey.action = 0
> mousewheel.horizscroll.withnokey.numlines = 1
> mousewheel.horizscroll.withnokey.sysnumlines = true

Hmm, mk, nice, I'll try that when evdev works properly. 

Now I see I got the same problem as you. I get two buttons pressed
when using the tilt wheel. Check my other reply for xev output.

The issue is also present in linux-2.6.11

-- 
Esben Stien is b0ef@esben-stien.name
http://www.esben-stien.name
irc://irc.esben-stien.name/%23contact
[sip|iax]:b0ef@esben-stien.name
