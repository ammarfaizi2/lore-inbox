Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSKNLkp>; Thu, 14 Nov 2002 06:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSKNLko>; Thu, 14 Nov 2002 06:40:44 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:35217 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264856AbSKNLko> convert rfc822-to-8bit; Thu, 14 Nov 2002 06:40:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Greg KH <greg@kroah.com>, Nick Craig-Wood <ncw1@axis.demon.co.uk>
Subject: Re: hotplug (was devfs)
Date: Thu, 14 Nov 2002 12:46:12 +0100
User-Agent: KMail/1.4.3
Cc: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
References: <20021112093259.3d770f6e.spyro@f2s.com> <20021113104809.D2386@axis.demon.co.uk> <20021113170204.GC5446@kroah.com>
In-Reply-To: <20021113170204.GC5446@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211141246.12833.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So - perhaps hotplug ought to be serialised?
>
> No, it's not needed for this problem.  There has been talk of
> serializing stuff in userspace, which is the proper way to handle some
> of the remove before add was seen problems.

We may need some kind of load control.
The thought of firing up hundreds of hotplug scripts
simultaneously is not pretty.

	Regards
		Oliver

