Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSBIECo>; Fri, 8 Feb 2002 23:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSBIECd>; Fri, 8 Feb 2002 23:02:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61960 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288248AbSBIEC3>;
	Fri, 8 Feb 2002 23:02:29 -0500
Message-ID: <3C649F4F.7E190D26@mandrakesoft.com>
Date: Fri, 08 Feb 2002 23:02:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Feb 08, 2002  18:25 -0800, Patrick Mochel wrote:
> > (I don't have a public repository yet, so there's no place to pull form)
> 
> I don't see why everyone who is using BK is expecting Linus to do a pull.
> In the non-BK case, wasn't it always a "push" model, and Linus would not
> "pull" from URLs and such?  Why are people not simply doing:
> 
> !bk send -r+ (other options) -
> 
> from within their editor (or equivalent) to inline the CSET in the email?
> This has the added advantage that other people reading the email can also
> import the CSET immediately if they so desire.

This is a good point...

'bk pull' is probably most useful to high volume submitters, where the
contents of most patches is either obvious and/or uninteresting.  'bk
send -d -r<rev> -' should be fine for importing.

But this is still a trial run of BK, so who knows what will wind up to
be the best policy for casual submitters.

And there's nothing wrong at all with sending GNU patches...

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
