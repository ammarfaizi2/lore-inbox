Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316799AbSGBPuv>; Tue, 2 Jul 2002 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSGBPuu>; Tue, 2 Jul 2002 11:50:50 -0400
Received: from vena.lwn.net ([206.168.112.25]:22280 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S316799AbSGBPuu>;
	Tue, 2 Jul 2002 11:50:50 -0400
Message-ID: <20020702155319.25599.qmail@eklektix.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 02 Jul 2002 11:20:19 EDT."
             <Pine.LNX.3.96.1020702111607.27954E-100000@gatekeeper.tmr.com> 
Date: Tue, 02 Jul 2002 09:53:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, as someone mentioned, it means a reboot every time you need to try
> something new while doing module development. That doesn't sound like a
> great idea...

This is a misconception I've seen go by a few times now; maybe I wrote up
that session badly.  Anyway...

...the module remove option, under the proposal, would not disappear
entirely.  It would just no longer be represented as safe.  Removable
modules would be a "kernel hacking" option, still available to people
developing drivers and such.  Aunt Tillie would no longer be able to remove
modules from her kernel, but that's not likely to bother her too much...

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
