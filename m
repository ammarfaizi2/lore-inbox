Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbTEFWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbTEFWS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:18:56 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:11392 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261993AbTEFWSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:18:54 -0400
Date: Tue, 6 May 2003 23:31:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030506223127.GD6284@mail.jlokier.co.uk>
References: <20030506164252.GA5125@mail.jlokier.co.uk> <1052242508.1201.43.camel@dhcp22.swansea.linux.org.uk> <20030506185433.GA6023@mail.jlokier.co.uk> <1052250792.1983.160.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052250792.1983.160.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > What if this new-fangled other kernel is open source, but BSD license
> > instead?  Would that also anger the kernel developers?  (As I suspect
> > a closed-source binary kernel would, even if one could get away with it).
> 
> Then the combined result would be a GPL'd product. You can do that now.
> Add BSD code to GPL and the result comes out GPL.

I disagree - as Pavel said, "if it's running in your kernel's
userspace", the GPL applies only to the thing running in that
"userspace", not to the whole combined machine.

> > Then, you can (a) rewrite everything, using the knowledge you gained
> > from reading the various open source drivers, or (b) just use those
> > drivers, and save a lot of effort.
> 
> The GPL says "you can use them if your final new result is GPL", the BSD
> world says "Hey go do it, just say thanks". Its probably a lot simpler
> to use the FreeBSD code if you don't want a GPL result.

I understand the licensing in unambiguous causes, and I'm not trying
to find loopholes in awkward corners.  I'm just observing that, as
closed-source binary modules are de facto accepted (with some funky
rules about which interfaces they can use), the same in reverse
_ought_ to be accepted to the same degree: Linux (and other) GPL'd
modules as satellites around a non-GPL kernel.

> For myself I'd be willing to discuss relicensing code in some cases but
> there is little that has a single author. 

Thanks.

-- Jamie

