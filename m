Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264539AbUDUKoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbUDUKoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 06:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUDUKox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 06:44:53 -0400
Received: from miranda.se.axis.com ([193.13.178.2]:61416 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264539AbUDUKoP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 06:44:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] kbuild: Documentation - how to build external modules
Date: Wed, 21 Apr 2004 12:44:12 +0200
Message-ID: <50BF37ECE4954A4BA18C08D0C2CF88CB227297@exmail1.se.axis.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] kbuild: Documentation - how to build external modules
Thread-Index: AcQnjRPQpskPVPj5TveVwMD312qt2AAAC2+A
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2004 10:44:12.0842 (UTC) FILETIME=[95AFE0A0:01C4278D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: sam@ravnborg.org [mailto:sam@ravnborg.org] 
> Sent: 21 April 2004 12:40
> To: Peter Kjellerstedt
> Cc: Sam Ravnborg; linux-kernel@vger.kernel.org
> Subject: Re: [RFC] kbuild: Documentation - how to build 
> external modules
> 
> >What about external modules that need to be configured
> >using make config & co? Is that possible with this system?
> 
> No, this is not possible for now.
> I have thought about a few ways of doing this.
> What I plan to look at is something where the local Kconfig
> file is read along with the .config for the kernel.
> The user will then anly be allowed to tweak config symbols
> defined for the external module, the kernel paramerets are not
> visible, and cannot be modified.

This sounds like what I was looking for.

> But this requires some kconfig tweaking, and first priority is
> to get the basic funtionality working so all (most) people
> are happy with it.

Well, we are still using 2.4, so it is no problem for us yet.
Better get the basics working first. :)

> If anyone has better ideas for handling Kconfig files for external
> modules please tell so.
> 
>   Sam

//Peter
