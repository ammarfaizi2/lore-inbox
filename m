Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbTLKT0D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbTLKT0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:26:03 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:21153
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265224AbTLKT0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:26:00 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Where did the ELF spec go?  (SCO website?)
Date: Thu, 11 Dec 2003 13:26:32 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <20031211094148.G28449@links.magenta.com> <20031211150011.GF8039@holomorphy.com>
In-Reply-To: <20031211150011.GF8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111326.32483.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 09:00, William Lee Irwin III wrote:
> On Wed, Dec 10, 2003 at 09:41:11PM -0800, William Lee Irwin III wrote:
> >> You're probably thinking of 2:2 split patches.
> >> 2:2 splits are at least technically ABI violations, which is probably
> >> why this isn't merged etc. Applications sensitive to it are uncommon.
> >> Yes, the SVR4 i386 ELF/ABI spec literally mandates 0xC0000000 as the
> >> top of the process address space.
>
> On Thu, Dec 11, 2003 at 09:41:48AM -0500, Raul Miller wrote:
> > Apologies if I'm asking about the obvious, but...
> > [1] isn't 0xC0000000 at 3GB?
>
> It is.
>
> On Thu, Dec 11, 2003 at 09:41:48AM -0500, Raul Miller wrote:
> > [2] Even if ELF did restrict a user process to 1GB (which I'm pretty
> > sure it doesn't), wouldn't the kernel still be able to manage 2GB of
> > user memory?
>
> You have it backward. The SVR4/i386 ELF ABI specification is requiring
> userspace to be granted at least 3GB of address space.

Where does one get a copy of the SVR4 spec these days?  The link I could track 
down went to http://www.sco.com/developer/devspecs/ which just ain't there no 
more.

And no, not because of a "DDOS".  There isn't one.  SCO's website IP moved 
from 216.250.128.13 to 216.250.128.20, and it's up at the new IP right now.  
They didn't get the new DNS record propogated on time.  Rookie mistake...

But looking at http.://216.250.128.20/developer/devspecs redirects you to the 
/developer page.  The devspecs page went away...

Is this mirrored somewhere?

Rob
