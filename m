Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274055AbRIXRQQ>; Mon, 24 Sep 2001 13:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274064AbRIXRQL>; Mon, 24 Sep 2001 13:16:11 -0400
Received: from smtp-server2.cfl.rr.com ([65.32.2.69]:30412 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S274054AbRIXRPy>; Mon, 24 Sep 2001 13:15:54 -0400
Date: Mon, 24 Sep 2001 13:16:10 -0400
From: Rick Haines <rick@kuroyi.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010924131610.A25181@sasami.kuroyi.net>
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 12:40:44PM -0400, Arjan van de Ven wrote:

> Sigma designs	- driver for soundcard

That's their NetStream 2000 DVD (mpeg/ac3) decoder.
There are reverse engineered (GPL) drivers for the Hollywood Plus.

As a side note, there are currently 4 misc minor numbers allocated to
the em8300 drivers (according to Documentation/devices.txt).  That's
fine for one card but the driver support up to 4 cards so we'd need 16
devices in that case.  Currently we're using major number 121.  Does
anyone have suggestions for moving over to official device numbers?

-- 
Rick (rick@kuroyi.net)
http://dxr3.sourceforge.net

I think the slogan of the fansubbers puts
it best: "Cheaper than crack, and lots more fun."
