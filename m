Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUFNGGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUFNGGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 02:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUFNGGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 02:06:25 -0400
Received: from mailout.despammed.com ([65.112.71.29]:17117 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S261991AbUFNGGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 02:06:21 -0400
Date: Mon, 14 Jun 2004 00:52:56 -0500 (CDT)
Message-Id: <200406140552.i5E5quk25119@mailout.despammed.com>
From: ndiamond@despammed.com
To: linux-kernel@vger.kernel.org
Subject: Re: Panics need better handling
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau replied to me:

>> But surely every developer or maintainer
>> of every driver or other part of the
>> kernel also has a clear need for every
>> Linux user to install this. I am not
>> the only one who needs to get these
>> reports, right? Shouldn't this be in
>> the main kernel tree by now, and enabled
>> by default?
>
> Well, yes and no. Yes because it's useful, no because there are so many
> other useful tools which would largely replace it and be more complete
> (kdb, lkcd, ...) that one could wonder why it's in the kernel at all.

Every developer or maintainer of every
driver or other part of the kernel wants
every Linux user to use kdb etc.?
I sure hope not.

> Since it's mainly useful to developers, and not too much intrusive, people
> who need it can easily apply it to their tree.

The information contained in the panic
reports is mainly useful to developers.
By not making the information visible
by default to end users, developers
avoid getting reports from end users.
Is this really what we want?  Do we
want to get reports only from failures
that we personally experience?

Although a particular big company is
famous for that attitude (including
not allowing end users to submit bug
reports unless we pay 4,200 yen to
make the submission), it's interesting
that their X Windows version sometimes
offers to call home with a crash report
after rebooting.  They're no longer
100% dedicated to closing their ears
to failures in the field.  Maybe Linux
isn't ready for this yet, but surely
we should not discourage reports from
end users?
