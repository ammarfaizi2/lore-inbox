Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVE3WpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVE3WpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVE3WpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:45:22 -0400
Received: from opersys.com ([64.40.108.71]:33039 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261797AbVE3WoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:44:25 -0400
Message-ID: <429B99B4.9090005@opersys.com>
Date: Mon, 30 May 2005 18:54:44 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, James Bruce <bruce@andrew.cmu.edu>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com>
In-Reply-To: <20050530222747.GB9972@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> Think about what you need to do for app that does sound (hard RT),
> 3d drawing (mostly soft RT for this example), reading disk IO that's
> buffered.
> 
> By the time you get the sound playback and IO buffering going, you're
> going to get a pretty complicated commuication layer already going
> from those points. Now think, what if you intend to do a FFT over that
> data and display it ?
> 
> It's starting to get unmanagably complicated at that point.

But that's a general argument for having hard-rt in the standard
kernel. Which one of these steps cannot, from your point of view,
be implemented in a nanokernel archiecture? ... keeping in mind
that, as Andi mentioned, the need for increased responsivness for
the mainstream kernel is relevant with or without PREEMT_RT and
that increasing responsiveness is a never-ending work-in-progress.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
