Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbTDFVT1 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTDFVT0 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:19:26 -0400
Received: from smtp03.web.de ([217.72.192.158]:17181 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263096AbTDFVTZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:19:25 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Jeff Randall <randall@uph.com>
Subject: Re: Serial port over TCP/IP
Date: Sun, 6 Apr 2003 23:30:47 +0200
User-Agent: KMail/1.5
References: <200304061447.46393.freesoftwaredeveloper@web.de> <200304062247.45525.freesoftwaredeveloper@web.de> <20030406161206.A12616@uph.com>
In-Reply-To: <20030406161206.A12616@uph.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304062330.47814.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 April 2003 23:12, Jeff Randall wrote:
> On Sun, Apr 06, 2003 at 10:47:45PM +0200, Michael Buesch wrote:
> > On Sunday 06 April 2003 22:14, Jeff Randall wrote:
> > > Yes, it would be very possible to do.
> >
> > Yes, but after Rob posted this script
> >[...]
> > do you think it's still neccessary to develop a driver?
> > I don't think so.
>
> Depends what kind of flexiblity you want.  If you have no need to support
> IOCTL's remotely, that script is probably sufficient.

Hm, that's the point. I don't know if ioctls are needed, because I'm not the
user of this "network COM-port", but only the possible developer. :)
I'll ask the person, who requested this feature tomorrow.

I think ioctls might be needed for his application. But the simple
nc-script doesn't provide them.

One thing is clear: For server-side there is no need for kernel-support.
But for the client kernel-support might be the best solution.

Regards Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

