Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbTFMLQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 07:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265355AbTFMLQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 07:16:00 -0400
Received: from mail.ithnet.com ([217.64.64.8]:43789 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265352AbTFMLP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 07:15:59 -0400
Date: Fri, 13 Jun 2003 13:29:31 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: John Bradford <john@grabjohn.com>
Cc: jw@pegasys.ws, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc8
Message-Id: <20030613132931.64125055.skraw@ithnet.com>
In-Reply-To: <200306120859.h5C8xuh7000958@81-2-122-30.bradfords.org.uk>
References: <200306120859.h5C8xuh7000958@81-2-122-30.bradfords.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003 09:59:56 +0100
John Bradford <john@grabjohn.com> wrote:

> > Saying it is a bad idea to release a kernel with known bugs
> > is like saying it is a bad idea to buy a computer when the
> > price will be going down soon.  Would you care to delay
> > 2.4.21 until next spring or would you rather get the fixes
> > it contains today and have 2.4.22 with your pet fix on
> > (hopefully) a scale of weeks?
> 
> A lot of the known bugs have fixes which appear to be OK, but haven't
> really had enough testing to go in to a -final tree.  A lot of them
> won't have been tested on SMP boxes for example.

One of the more important things in kernel development - according to my
personal opinion - is the fact that there is _one_ main tree and you may well
ignore others. The more you split up, the less testing there will be. There is
only a certain amount of people that really use not-released kernels. If you
produce more branches the total amount of tests done will not really increase
but rather decrease (per branch) because of the split-up.
Don't do that, please
And another thing is: your proposal seems to increase load on the maintree
maintainer. I don't think this is the right way to go. I would rather say the
subsytem maintainers should be more involved. Which means: if a subsystem does
not work as expected or the patches are a mess, then I'd say it's the maintree
maintainers job to kick the a** of the subsystem maintainer to solve it, and
not to solve the problem himself. Surely he can give hints and suggestions -
who wouldn't - but the work should be done by the maintainer. I think this is
the fundamental idea behind maintainership.

Regards,
Stephan
