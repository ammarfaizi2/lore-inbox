Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVAOBsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVAOBsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAOBlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:41:47 -0500
Received: from [81.2.110.250] ([81.2.110.250]:37353 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262099AbVAOBiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:38:07 -0500
Subject: Re: Kernel releases for security updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Gregory Boyce <gboyce@badbelly.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E77C76.3070204@bio.ifi.lmu.de>
References: <Pine.LNX.4.61.0501121340560.20156@buddha.badbelly.com>
	 <41E77C76.3070204@bio.ifi.lmu.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105743308.9839.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:32:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-14 at 08:01, Frank Steiner wrote:
> I guess the new -as tree is more or less achieving what you want. If
> Andres gets enough support from other people, it might be possible to
> maintain even more than one or two former releases...

The problem is deciding what goes into such a tree. Do you go security
fixes only which nobody afaik is doing now, do you mix them with key
fixes and if so how far do you add fixes - thats a real PITA because you
can get odd clear fixes for minor problems (eg NFS df) that have never
been tested hard standalone. You can also get dependancies on
non-security fixes for security - -ac for example included my IDE work
to deal with the various IDE exploits/races. Though only minor security
wise there isn't a trivial fix for these with the broken locking in
Linus IDE and its going to take time for Bartlomiej to be happy with my
locking changes.


Alan

