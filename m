Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUAWJid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUAWJic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:38:32 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:22085 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S266539AbUAWJhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:37:06 -0500
Subject: Re: uk keyboard broken by input updates?
From: Bastien Nocera <hadess@hadess.net>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, kieran@ihateaol.co.uk,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040123012927.6cddd754.akpm@osdl.org>
References: <1073901824.29420.14.camel@bnocera.surrey.redhat.com>
	 <40027510.1080600@ihateaol.co.uk> <20040112103256.GA4038@ucw.cz>
	 <1074848307.2358.1.camel@wyatt.hadess.net>
	 <20040123012927.6cddd754.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074850622.2358.9.camel@wyatt.hadess.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 23 Jan 2004 09:37:02 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 09:29, Andrew Morton wrote:
> Bastien Nocera <hadess@hadess.net> wrote:
> >
> > Hello Vojtech,
> > 
> > Is there any particular reason why this didn't make it into 2.6.2-rc1? I
> > just checked the 2.6.1 to 2.6.2-rc1 patch, and the only change to
> > char/keyboard.c seems to be a change in an #ifdef.
> > 
> > > -	 80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
> > > -	284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
> > > +	 80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
> > > +	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
> 
> These changes were merged post-2.6.2-rc1.  Please test 2.6.2-rc1-mm2 or the
> latest bk snapshot.

Thanks Andrew for the notice. I'll test out as soon as I can.

Cheers

---
Bastien Nocera <hadess@hadess.net> 
Remember the 3 golden rules: 1. It was like that when I got here. 2. I
didn't do it. 3. (To your Boss) I like your style.

