Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWDYPQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWDYPQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWDYPQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:16:31 -0400
Received: from styx.suse.cz ([82.119.242.94]:25579 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932251AbWDYPQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:16:31 -0400
Date: Tue, 25 Apr 2006 17:16:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Message-ID: <20060425151628.GA11078@suse.cz>
References: <20060422204844.GA16968@skyscraper.unix9.prv> <d120d5000604240731i5a3667f9g37e94de390485aac@mail.gmail.com> <20060424145747.GA5906@suse.cz> <d120d5000604240803q387343dt8e9801a8cf21a975@mail.gmail.com> <d120d5000604250619r6170c18bh8d26fc041141c056@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000604250619r6170c18bh8d26fc041141c056@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 09:19:42AM -0400, Dmitry Torokhov wrote:
> On 4/24/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On 4/24/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > On Mon, Apr 24, 2006 at 10:31:39AM -0400, Dmitry Torokhov wrote:
> > > >
> > > > Vojtech, could you remind me why EVIOC{G|S}REP were removed? Some
> > > > people want to have ability to separate keyboards (via grabbing); they
> > > > also might want to control repeat rate independently. Shoudl we
> > > > reinstate these ioctls?
> > >
> > > I believe they were replaced by the ability to send EV_REP style events
> > > to the device, setting the repeat rate.
> > >
> >
> > Argh, why am I always forgetting about ability to write events into devices?
> 
> Thinking about it some more - writing to the event device is an
> elegant way to set repeat rate but how do you retrieve current repeat
> rate for a given device?
 
You can't. And that's likely a problem that needs fixing.

-- 
Vojtech Pavlik
Director SuSE Labs
