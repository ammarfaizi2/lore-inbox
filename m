Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbTEUNwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 09:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTEUNvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 09:51:10 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:9485 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262095AbTEUNiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 09:38:54 -0400
Date: Wed, 21 May 2003 15:51:54 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
Message-ID: <20030521135154.GA15462@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <16075.8557.309002.866895@napali.hpl.hp.com> <1053507692.1301.1.camel@laptop.fenrus.com> <3ECB57A4.1010804@octopus.com.au> <1053522732.1301.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053522732.1301.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 03:12:12PM +0200, Arjan van de Ven wrote:
> if you had spent the time you spent on this colorful graphic on reading
> SUS or Posix about what sched_yield() means, you would actually have
> learned something. sched_yield() means "I'm the least important thing in
> the system".

Susv2:

DESCRIPTION

 The sched_yield() function forces the running thread to relinquish
 the processor until it again becomes the head of its thread list. It
 takes no arguments.


Aka "I skip the rest of my turn, try the others again once", not "I'm
unimportant" nor "please rerun me immediatly".

What is it with you people wanting to make sched_yield() unusable for
anything that makes sense?

  OG.

