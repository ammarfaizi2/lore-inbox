Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWGXPWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWGXPWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWGXPWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:22:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:35589 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750857AbWGXPWx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:22:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k0lTVCL5GQDnptMgD62x819mGOLN4nhWzbRmxzDx5OfLecH97tbt/h3Zo0OMoe85W1BH7lmN0Msxjc6pAU0TiUDagj6iFKQFhO3I7PGV5FxhLo/39qznHHNo8J95JHOPosOhrDEUIleNAFdLPdsoJzdCWueAiYbvSDu5B2cJz3I=
Message-ID: <d120d5000607240822j7c506935p5575f1d5dbbbd210@mail.gmail.com>
Date: Mon, 24 Jul 2006 11:22:51 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Daniel Stone" <daniel@fooishbar.org>
Subject: Re: [RFC] input: Wacom tablet driver for simple X hotplugging
Cc: "=?ISO-8859-1?Q?Magnus_Vigerl=F6f?=" <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20060724151159.GA5082@fooishbar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060721211341.5366.93270.sendpatchset@pipe>
	 <200607212209.05254.dtor@insightbb.com>
	 <20060724151159.GA5082@fooishbar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/06, Daniel Stone <daniel@fooishbar.org> wrote:
> On Fri, Jul 21, 2006 at 10:09:04PM -0400, Dmitry Torokhov wrote:
> > On Friday 21 July 2006 17:13, Magnus Vigerlöf wrote:
> > > I'd appreciate whether you think this is a viable idea to make it as a
> > > generic driver instead or should I continue with the Wacom-specific
> > > one. I know the 'right' thing would be to make X truly hot-plug aware,
> > > but this driver is something that would be possible to use in current
> > > systems without any problems.
> > >
> >
> > Yes, I think fixing X would ultimately be time better spent.
>
> It's already mostly done, and should hopefully land for 7.2.  It's a
> neat concept, along the lines of /dev/input/mice, but the time for that
> kind of pathological braindamage is long gone.
>

Oh that is the great news!

-- 
Dmitry
