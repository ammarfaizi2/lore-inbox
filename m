Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVBJTuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVBJTuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVBJTuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:50:52 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:51779 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261334AbVBJTur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:50:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EVRSso3PN4YFBApZq6B6Fx2TqZiys3lRHM6Gax6iWCsB9yc28h++mh1Orn1FdknZPIRQIvTjNjUjPF1CEGdtrkQa3QVyjdzGVQ1ydeKjHGfaQ2HmcGlyUvzajatvpzfRqDuL0tWh3e63Md9Tx/YWhFdE4W9WRQC+1zSZ+m02hLM=
Message-ID: <d120d50005021011503b4841c@mail.gmail.com>
Date: Thu, 10 Feb 2005 14:50:47 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFC] Linux Kernel Subversion Howto
Cc: Steve Lee <steve@tuxsoft.com>, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
In-Reply-To: <20050210192319.GA1864@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <000001c50f8f$7f420420$8119fea9@pluto>
	 <20050210192319.GA1864@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 20:23:19 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Feb 10, 2005 at 10:42:15AM -0600, Steve Lee wrote:
> 
> > Roman, besides BK being closed source, how exactly is it lacking for
> > your needs?  If what it lacks is a good idea and helps many, Larry and
> > crew might be willing to add whatever it is you need.
> 
> A feature I lack is 'floating changesets', that would keep always at the
> top of the history, rediffed, remerged and updated as other changesets
> come in.
> 
> I know quilt can do it, but quilt can't do other things I like on bk.
> 

I have switched from BK to BK + quilt - I use BK to do pull from
various trees and merge it all together and then quilt to drop my
work-in-progress on top and refresh (rediff) so there are no offests.

So far it is very handy

-- 
Dmitry
