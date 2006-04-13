Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWDMMmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWDMMmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 08:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWDMMmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 08:42:16 -0400
Received: from wproxy.gmail.com ([64.233.184.231]:44265 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964911AbWDMMmQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 08:42:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iXavO8nQAaskURdaGNV4p09XJ9B5akEX6T+/ObW1dOjUr6ig5+4SZAGHmWi2sqvE+6HJQmgOxhhNukFiHdgTS0nk05hQOOpQc/iqqbWBYZjtqZky8izpGJtNxsig7Z4Me6SVmW1U7dsmALx45Z4nGoX+DFULOhqVdyGkpB4utGg=
Message-ID: <9a8748490604130542y783e604ew93aea8e4997c3f57@mail.gmail.com>
Date: Thu, 13 Apr 2006 14:42:15 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Tim Phipps" <tim@phipps-hutton.freeserve.co.uk>
Subject: Re: p4-clockmod not working in 2.6.16
Cc: "Mike Galbraith" <efault@gmx.de>, linux-kernel@vger.kernel.org,
       "Edgar Toernig" <froese@gmx.de>, "Dave Jones" <davej@redhat.com>
In-Reply-To: <200604131320.58800.tim@phipps-hutton.freeserve.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1142974528.3470.4.camel@localhost>
	 <1144245205.7571.11.camel@homer> <1144245577.7571.16.camel@homer>
	 <200604131320.58800.tim@phipps-hutton.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/06, Tim Phipps <tim@phipps-hutton.freeserve.co.uk> wrote:
> On Wednesday 05 Apr 2006 14:59, Mike Galbraith wrote:
> > On Wed, 2006-04-05 at 13:02 +0100, Tim Phipps wrote:
> > > Here's a patch to 2.6.17-rc1 that disables the 12.5% DC on any CPU that
> > > has N60. The frequencies in the errata are a bit vague so this is the
> > > safe bet and it only disables one of the eight frequencies rather than
> > > the current behaviour which disables all of mine!
> >
> > Works for me.  Perhaps you should update...
> > dprintk("has errata -- disabling frequencies lower than 2ghz\n");
> > ...,slap a Signed-off-by: on it and see if it flys.
>
> Not sure how to do a Signed-off-by but here's the patch.
>

It's simple. Here's what you do :

1. Read Documentation/SubmittingPatches, especially the "Developer's
Certificate of Origin 1.1" bit.

2. Make sure you agree/comply with above mentioned Developer's cert.,
then add a line like this just above your patch:
Signed-off-by: Tim Phipps <tim@phipps-hutton.freeserve.co.uk>


(ohh and please submit patches inline in emails if at all possible,
not as attachments, thanks)  :-)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
