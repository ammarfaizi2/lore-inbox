Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbVJEXgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbVJEXgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbVJEXgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:36:44 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:62394 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030438AbVJEXgn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:36:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sNfkfPM3mSJKMiDBfJAv3M5hpRfkLQWoNjMulpGntBc0Ve1ZIiXYneyAqAfSfLjBr57zAUcuOnNYxDaFV3YU7gF0pgsPUXjbIdZSL9k52FYOKBXvFxfuTmMx9/M20depkUVjxa15T3SEvBDJZe2OHDJqw43eDDTjBv9fwui+Qgo=
Message-ID: <21d7e9970510051636g29012748o77124c1c1abc9259@mail.gmail.com>
Date: Thu, 6 Oct 2005 09:36:42 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Nix <nix@esperi.org.uk>
Subject: Re: Why no XML in the Kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8764sbwoj7.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
	 <35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com>
	 <87oe66r62s.fsf@amaterasu.srvr.nix>
	 <20051003153515.GW7992@ftp.linux.org.uk>
	 <87zmpqbcws.fsf@amaterasu.srvr.nix>
	 <21d7e9970510051411y2f2871a7mafa2e96cce277657@mail.gmail.com>
	 <87br23odls.fsf@amaterasu.srvr.nix>
	 <21d7e9970510051557u42ae32f0rca46e951c5da536f@mail.gmail.com>
	 <8764sbwoj7.fsf@amaterasu.srvr.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Ah. So, er, the DRM<-> userspace protocol is stable, then?
>
> Looks like I was working on bad assumptions (assuming the DRM and X were
> tied). I'm not sure where those assumptions came from. Possibly just
> that they shared a CVS repo, although I'd hope I'd had more evidence
> than that. I realy can't recall.

In theory yes, on occasion I do get bugs that break XFree86 4.3, but
these are bugs as opposed to design decisions, upgrading the kernel
should never require upgrading to a new  version of X or anything like
that, however upgrading X can sometimes require a newer kernel in
order to take advantage of newer drm features.. but X should always
work with the older drms...

Dave.
