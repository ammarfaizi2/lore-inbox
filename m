Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277792AbRJRQcC>; Thu, 18 Oct 2001 12:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRJRQbw>; Thu, 18 Oct 2001 12:31:52 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:8968 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S277798AbRJRQbp>;
	Thu, 18 Oct 2001 12:31:45 -0400
Date: Thu, 18 Oct 2001 18:32:17 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Input on the Non-GPL Modules
Message-ID: <20011018183217.A5055@gondor.com>
In-Reply-To: <Pine.LNX.4.21.0110181113020.9058-100000@wyrm.rakis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110181113020.9058-100000@wyrm.rakis.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 11:29:57AM -0400, Greg Boyce wrote:
> However, with the addition of GPL only symbols, you add motivation for
> conning.  Not by end users, but by the developers of binary only
> modules.  If they export the GPL license symbol, they gain access to
> kernel symbols that they may want to use.  Since no code is actually being
> stolen, would this kind of trick actually cause a licensing violation?

What about a different way of circumventing the GPL only symbols?

What prevents the author of a non-GPL module who needs access to a
GPL-only symbol from writing a small GPLed module which imports the 
GPL-only symbol (this is allowed, because the small module is GPL), 
and exports a basically identical symbol without the GPL-only
restriction?

Then he could use this new symbol from his non-GPL module.

Jan

