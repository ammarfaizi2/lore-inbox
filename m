Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTJ3FqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 00:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTJ3FqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 00:46:15 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:48547
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262193AbTJ3FqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 00:46:14 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Steven Cole <elenstev@mesatop.com>
Subject: Re: Suspend to disk panicked in -test9.
Date: Wed, 29 Oct 2003 23:43:04 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200310291857.40722.rob@landley.net> <200310291935.28554.elenstev@mesatop.com> <Pine.LNX.4.53.0310292223190.9199@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0310292223190.9199@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310292343.04963.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 October 2003 21:24, Zwane Mwaikambo wrote:
> On Wed, 29 Oct 2003, Steven Cole wrote:
> > In the meantime, keeping a digital camera close by when testing is a
> > low tech/high tech solution to this.
> >
> > Steven
>
> Or you could just disable screen blanking entirely; setterm(1)

Ah, cool.  Thanks.  (It's now in my init script.)

Do you know if this affects x's screensaver timeout?  (Probably not, but I'm 
not sure how to look it up.  Maybe X gets the value from console 7, somehow?  
Then again, if this was a per-console thing setting it in the initscripts 
when the console is /dev/console rather than virtual wouldn't necessarily 
work...  Huh.)

Rob
