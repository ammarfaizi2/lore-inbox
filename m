Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTGCQN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTGCQLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:11:37 -0400
Received: from pangsit.kjoe.net ([145.98.147.119]:640 "EHLO pangsit.kjoe.net")
	by vger.kernel.org with ESMTP id S264850AbTGCQCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:02:02 -0400
Date: Thu, 3 Jul 2003 17:09:32 +0200
To: Peter Osterlund <petero2@telia.com>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics trouble in 2.5.73
Message-ID: <20030703150932.GB19538@surfnet.nl>
References: <20030702185412.GA24350@outpost.ds9a.nl> <m2fzlnzybr.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2fzlnzybr.fsf@telia.com>
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.4i
From: Niels den Otter <otter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Thursday,  3 July 2003, Peter Osterlund wrote:
> > I saw mention of special X drivers for this, but the kernel messages
> > appear to indicate that the kernel itself is not succeeding in
> > communicating with the touchpad.
> 
> The kernel messages could very well indicate that the communication
> works 99.9% of the time, but you really need the special X driver or
> else the touchpad will not work at all in X.

I am using the special driver in X and this works fine after a cold
boot. However after a hibernation of my laptop the mouse doesn't work
and syslog reports:

Jul  3 17:05:34 pangsit kernel: Synaptics driver lost sync at 1st byte
Jul  3 17:05:43 pangsit last message repeated 968 times
Jul  3 17:05:49 pangsit kernel: Synaptics driver lost sync at 1st byte
Jul  3 17:06:14 pangsit last message repeated 3773 times
Jul  3 17:07:12 pangsit kernel: Synaptics driver lost sync at 1st byte
[etc]

I have to reboot my laptop to get it working again.


-- Niels
