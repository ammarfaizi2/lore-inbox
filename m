Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264892AbTIDXBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265567AbTIDXBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:01:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:14477 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264892AbTIDXBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:01:03 -0400
Date: Fri, 5 Sep 2003 00:00:55 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org,
       vojtech@ucw.cz, Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030904230055.GO31590@mail.jlokier.co.uk>
References: <20030903235647.C765.CHRIS@heathens.co.nz> <20030904204816.GD31590@mail.jlokier.co.uk> <20030905003436.A3105@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905003436.A3105@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> Ha! We maintain two such bitmaps. And they get out of sync too.
> 
> You talk too easily. "If you receive a release event".
> But one does not receive release events, one receives bytes.
> The interpretation of those bytes belongs to the keyboard driver.
> 
> But i8042.c needs to know whether scancodes are releases
> in order to do its massaging of the scancodes before giving
> them to the keyboard driver.

Are you saying that it isn't possible for i8042.c to simply pass all
events (including duplicates) to the keyboard driver to sanitise?

-- Jamie
