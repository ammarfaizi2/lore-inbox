Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWBLIXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWBLIXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 03:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBLIXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 03:23:24 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:20490 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S932327AbWBLIXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 03:23:23 -0500
Date: Sun, 12 Feb 2006 09:23:15 +0100
From: iSteve <isteve@rulez.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060212092315.10f3e0e2@silver>
In-Reply-To: <43EE8B20.7000602@cfl.rr.com>
References: <20060211103520.455746f6@silver>
	<m3r76a875w.fsf@telia.com>
	<20060211124818.063074cc@silver>
	<m3bqxd999u.fsf@telia.com>
	<20060211170813.3fb47a03@silver>
	<43EE446C.8010402@cfl.rr.com>
	<20060211211440.3b9a4bf9@silver>
	<43EE8B20.7000602@cfl.rr.com>
X-Mailer: Sylpheed-Claws 2.0.0cvs42 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The thing is, I'd like to be able to set up a CDRW for packet writing and burn
some data there (not necessarily UDF filesystem, it should be able to, for
example, undergo encryption; and it may not be UDF filesystem at all) without
actually having to use UDF and packet writing on the burning side...

That is: Set up CDRW for packet writing. Burn something non-UDF there. Move it
elsewhere. Use packet writing to access it r/w. Can I do that?:) I've been
playing with cdrecord's -packet and pktsize options atm, the only thing I got
was a CDRW that apparently blocks all reading.
-- 
 -- iSteve
