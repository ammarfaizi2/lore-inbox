Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTKSKA4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTKSKA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:00:56 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:21008 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S263791AbTKSKAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:00:55 -0500
Date: Wed, 19 Nov 2003 11:00:54 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Cc: jlamanna@ugcs.caltech.edu
Subject: Re: e-Galax USB touchscreens and 2.4
Message-ID: <20031119100054.GA29891@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has anyone ever gotten an e-Galax USB touchscreen to work under linux 2.4?
> They do have a module on their website, however it appears to not work.
> I, unfortunately, do not know enough about the USB subsystem to debug the problems with it.

I had a terminal with eGalax touchscreen for tests some time ago and it
worked.
But for new USB core (Linux 2.4.20+) it required a patch (unpatched
driver worked on 2.4.18 but caused Oops on 2.4.20):
http://cvs.pld-linux.org/SOURCES/touchkit-2.4.20.patch

(yes, it uses old GNU-style initializers, now I would use C99-style)


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/
