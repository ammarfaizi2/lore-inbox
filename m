Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbTJAPkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTJAPkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:40:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31128 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262384AbTJAPkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:40:42 -0400
Date: Wed, 1 Oct 2003 16:40:40 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Lisa R. Nelson" <lisanels@cableone.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
Message-ID: <20031001154040.GU7665@parcelfarce.linux.theplanet.co.uk>
References: <1065012013.4078.2.camel@lisaserver> <20031001132318.GS7665@parcelfarce.linux.theplanet.co.uk> <1065017722.2995.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065017722.2995.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 08:15:23AM -0600, Lisa R. Nelson wrote:
> Excuse me? Have you even read about permissions on Unix?  I tried this
> on a Sun Unix system, and the Sun functions correctly.  What you are
> saying is stupid; If all directories are wide open, NO files are
> protected in any way, even if they are read only and owned by root?  Get
> real.  

What, create a world-writable directory without sticky bit and then wonder
why everyone can remove files from there?

Would you mind posting the list of systems (with versions, preferably)
where that behaviour would *not* match v7, 2.xBSD, 4.xBSD and derivatives
(including SunOS 4), SunOS 5.5, SunOS 5.6, SunOS 5.7,  SunOS 5.8, Linux,
OSF/1, etc.?

In particular, I'm most curious about the exact version of "Sun Unix"
you claim to have tried that on.  That, and output of ls -ld on the
directory in question.

> I've worked on more OS's than you can imagine, and for many years.  This

The sad thing being, that's one claim I do *not* doubt.  Lusers' ability
to avoid learning for years had stopped amazing me a long time ago...
