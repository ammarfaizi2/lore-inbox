Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbUJ3Pld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUJ3Pld (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUJ3PkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:40:18 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:5958 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261274AbUJ3Pgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:36:50 -0400
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
From: Paul Fulghum <paulkf@microgate.com>
To: Greg KH <greg@kroah.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Oleksiy <Oleksiy@kharkiv.com.ua>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041030034920.GA1501@kroah.com>
References: <416A6CF8.5050106@kharkiv.com.ua>
	 <20041012171004.GB11750@kroah.com> <20041023180625.GA12113@logos.cnet>
	 <1098572412.5996.6.camel@at2.pipehead.org>
	 <1098576844.5996.27.camel@at2.pipehead.org>
	 <1098908206.2856.17.camel@deimos.microgate.com>
	 <20041030034920.GA1501@kroah.com>
Content-Type: text/plain
Message-Id: <1099150595.6584.6.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 30 Oct 2004 10:36:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 22:49, Greg KH wrote:
> On Wed, Oct 27, 2004 at 03:16:46PM -0500, Paul Fulghum wrote:
> > Here is a patch that applies the error only to the
> > next receive byte instead of all bytes in the
> > next read bulk packet.
> > 
> > Greg: Any comment?
> 
> Your patch looks sane, thanks.
> 
> > Oleksiy: Can you try this patch?
> 
> Let us know if this works or not.  If so, Paul, care to resend this for
> 2.6 also?

Sure, I'm just waiting for word from Oleksiy.

-- 
Paul Fulghum
paulkf@microgate.com


