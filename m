Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbTLEP3u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 10:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTLEP3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 10:29:50 -0500
Received: from zork.zork.net ([64.81.246.102]:53394 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264352AbTLEP3t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 10:29:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Double-click on touchpad
References: <1070610304.4328.14.camel@idefix.homelinux.org>
	<20031205093200.GA8877@nasledov.com>
	<1070637392.12400.1.camel@idefix.homelinux.org>
Reply-To: Sean Neakums <sneakums@zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 05 Dec 2003 15:29:47 +0000
In-Reply-To: <1070637392.12400.1.camel@idefix.homelinux.org> (Jean-Marc
 Valin's message of "Fri, 05 Dec 2003 10:16:33 -0500")
Message-ID: <6ubrqn2sgk.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca> writes:

> Le ven 05/12/2003 à 04:32, Misha Nasledov a écrit :
>> Do you have both /dev/psaux and /dev/input/mice in your XF86Config file? In
>> 2.6, these are the same thing, so it actually opens the same mouse twice and
>> it can cause such weird issues with it.
>
> OK, I removed /dev/input/mice and it now behaves correctly. Now I'm just
> not sure how I can add a secondary USB mouse in these conditions...

You could restore /dev/input/mice mice and remove /dev/psaux instead.

-- 
Not bad, for a human.
