Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbTCRG01>; Tue, 18 Mar 2003 01:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262186AbTCRG01>; Tue, 18 Mar 2003 01:26:27 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:42407 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S262184AbTCRG00>; Tue, 18 Mar 2003 01:26:26 -0500
Date: Tue, 18 Mar 2003 18:35:02 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PATCH] Don't refill pcp lists during SWSUSP.
In-reply-to: <20030317222018.5c7f7a56.akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1047969302.2309.16.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1047945372.1714.19.camel@laptop-linux.cunninghams>
 <20030317160556.4efc880f.akpm@digeo.com>
 <1047965222.2430.3.camel@laptop-linux.cunninghams>
 <20030317222018.5c7f7a56.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 18:20, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@clear.net.nz> wrote:
> > I said I was going to use dynamically allocated bitmaps instead of page
> > flags. Do you mind if I do use pageflags after all (at least for the
> > moment)? I've used one in the generate_free_page_map patch, and need one
> > more to mark pages which will be saved in another pageset.
> > 
> 
> I think it'd be best to avoid using more flags if poss.  We are getting
> short, and designing for this now is probably less trauma than going
> through and redoing your stuff later.

Okay. I'll add the dynamic bitmap code and redo the previous patch.

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

