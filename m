Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVAYUjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVAYUjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVAYUjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:39:11 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5267 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262129AbVAYUhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:37:39 -0500
Subject: Re: i8042 access timings
From: Lee Revell <rlrevell@joe-job.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20050125194647.GB3494@pclin040.win.tue.nl>
References: <200501250241.14695.dtor_core@ameritech.net>
	 <20050125105139.GA3494@pclin040.win.tue.nl>
	 <d120d5000501251117120a738a@mail.gmail.com>
	 <20050125194647.GB3494@pclin040.win.tue.nl>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 15:37:35 -0500
Message-Id: <1106685456.10845.40.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 20:46 +0100, Andries Brouwer wrote:
> On Tue, Jan 25, 2005 at 02:17:33PM -0500, Dmitry Torokhov wrote:
> 
> > Still, I wonder if implementing these delays will give IO controller
> > better chances to react to our queries and will get rid of some
> > failures.
> 
> My objection is this: by doing this you create myths that may
> be difficult to dispel later. I recall other situations where
> there were superfluous restrictions and I had a hard time convincing
> others of the fact that the tests weren't there for any good reason,
> that there was no single instance of hardware on earth known to
> work better with the added restrictions.

Seems like a comment along the lines of "foo hardware doesn't work right
unless we delay a bit here" is the obvious solution.  Then someone can
easily disprove it later.

Lee

