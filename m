Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbUJ0WRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbUJ0WRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUJ0WOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:14:04 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:40033 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262931AbUJ0Vl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:41:58 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.10-rc1-bk5] e1000 broken badly on IBM T42
Date: Wed, 27 Oct 2004 17:41:54 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200410270033.22804.shawn.starr@rogers.com> <200410270521.56816.shawn.starr@rogers.com> <1098892310.8313.1.camel@krustophenia.net>
In-Reply-To: <1098892310.8313.1.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410271741.55039.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually, there is a bug, when suspending the laptop its not storing the 
negotiated link status and resets to gigabit.

This looks to be a bug :-)

Shawn.

On October 27, 2004 11:51, Lee Revell wrote:
> On Wed, 2004-10-27 at 05:21 -0400, Shawn Starr wrote:
> > I should just answer it myself, restarting fixed the interface
> > negotiation 'blip'. Perhaps the driver somehow did not reset and retry
> > negotiation?
> >
> > That did look interesting though :)
>
> AIUI it's impossible to do 100% reliable autonegotiation with Ethernet.
> The best you can do is try to detect when you might have gotten it wrong
> and reset the interface.
>
> Lee
