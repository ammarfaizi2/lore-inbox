Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWEMLpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWEMLpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWEMLpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:45:12 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:44088 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S932395AbWEMLpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:45:10 -0400
From: Mark Rosenstand <mark@borkware.net>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
In-Reply-To: <1147519329.3084.20.camel@gimli.at.home>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
	<1147519329.3084.20.camel@gimli.at.home>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060513114509.3A90D146AF@hunin.borkware.net>
Date: Sat, 13 May 2006 13:45:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch <bernd@firmix.at> wrote:
> On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:
> [...]
> > A more useful case is when you setuid the script (and no, this doesn't
> > need to be running as root and/or executable by all.)
> 
> Apart from the permission bug: This has been purposely disabled since it
> is way to easy to write exploitable shell or other scripts.
> Use a real programming languages, sudo or a trivial wrapper in C ....

It isn't a bug on systems that support executable shell scripts.
Doing security policy based on programming language seems weird at
best, especially when the only user able to make those decisions is the
superuser.

Obviously the security-unaware people over at the OpenBSD camp must be
completely clueless when they don't disallow the superuser to do this.
I'm looking forward to the day where I'm no longer allowed to make
changes to /etc/ld.so.conf because it's a system file.

Anyway, is it possible to enable this functionality?
