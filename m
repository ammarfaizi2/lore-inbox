Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286184AbRLTGzd>; Thu, 20 Dec 2001 01:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286183AbRLTGz1>; Thu, 20 Dec 2001 01:55:27 -0500
Received: from ns01.netrox.net ([64.118.231.130]:16312 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S285024AbRLTGzM>;
	Thu, 20 Dec 2001 01:55:12 -0500
Subject: Re: aio
From: Robert Love <rml@tech9.net>
To: Mike Castle <dalgoda@ix.netcom.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <20011220064651.GB32678@thune.mrc-home.com>
In-Reply-To: <20011219224717.A3682@redhat.com>
	<20011219.213910.15269313.davem@redhat.com>
	<20011220005803.E3682@redhat.com>
	<20011219.220040.55725223.davem@redhat.com> 
	<20011220064651.GB32678@thune.mrc-home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 20 Dec 2001 01:55:25 -0500
Message-Id: <1008831327.810.18.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-20 at 01:46, Mike Castle wrote:
> On Wed, Dec 19, 2001 at 10:00:40PM -0800, David S. Miller wrote:
> > No I'm not talking about phttpd nor zeus, I'm talking about the guy
> > who did the hacks where he'd put the http headers + content into a
> > seperate file and just sendfile() that to the client.
> > 
> > I forget what his hacks were named, but there certainly was a longish
> > thread on this list about it about 1 year ago if memory serves.
> 
> Would that be Fabio Riccardi's X15 stuff?

Yes.  I was about to reply to this effect.

X15 was a userspace httpd that operated using the Tux-designed
constructs -- sendfile and such.  IIRC, Ingo actually pointed out some
things Fabio did were non-RFC (sending the static headers may of been
one of them, since the timestamp was wrong) and Fabio made a lot of
changes.  X15 seemed promising, especially since it trumpeted that Linux
"worked" without sticking things in kernel-space, but I don't remember
if we ever saw source (let alone a free license)?

	Robert Love

