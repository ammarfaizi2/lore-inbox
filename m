Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTJ2PHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 10:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTJ2PHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 10:07:12 -0500
Received: from [65.171.77.205] ([65.171.77.205]:1554 "EHLO
	mx.digitalmortgage.cc") by vger.kernel.org with ESMTP
	id S261748AbTJ2PHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 10:07:11 -0500
From: Denis Perchine <dyp@perchine.com>
Organization: AcademSoft Ltd.
Subject: Re: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
Date: Wed, 29 Oct 2003 22:07:24 +0700
User-Agent: KMail/1.5.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310292107.24077.dyp@perchine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 October 2003 20:52, Brad House wrote:
> Interesting, I'll search through lkml for that.  The only thing
> I can say is that we're not seeing that on nForce3 w/x86_64, which
> is the only nforce mb I have access to, and it uses basically the
> same driver.

The same problem with nforce2 mobos on the latest 2.4.
It hangs. The only solution is to disable local APIC in BIOS.
After that it seems that there are no hangups.

> -Brad
>
> ross.alexander@uk.neceur.com wrote:
> > Brad,
> >
> > My problem is one of the infamous nforce2 hardlockups.  You don't get any
> > kernel panic or anything that useful.  The system just locks up
> > completely and has to be manually reset.
> >
> > The problem is known to associate with IDE activity and is thought (as
> > far as I know) to originate somewhere in the IDE driver.

--
Denis

