Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265168AbUFWR7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUFWR7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUFWR7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:59:49 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:51469 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265168AbUFWR7r (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:59:47 -0400
Date: Wed, 23 Jun 2004 19:59:45 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Philippe Troin <phil@fifi.org>
Cc: David Balazic <david.balazic@hermes.si>,
       "'Linux-Kernel@vger.kernel.org'" <Linux-Kernel@vger.kernel.org>
Subject: Re: Disk copy, last sector problem
Message-ID: <20040623175945.GB3072@pclin040.win.tue.nl>
References: <600B91D5E4B8D211A58C00902724252C01BC0700@piramida.hermes.si> <87smcncz6h.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87smcncz6h.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 09:52:54AM -0700, Philippe Troin wrote:
> David Balazic <david.balazic@hermes.si> writes:
> 
> > Hi!
> > 
> > cat /dev/hda > /dev/hdc
> > 
> > This would not copy the entire disk as expected, but miss the last sector if
> > the number of
> > sectors on hda is odd. ( I used "cat" becasue it has the simplest syntax,
> > "dd" and other behave the same ).
> > Has this been fixed recently ?
> > What about suppport of other sectors sizes, like 8kb ?
> 
> Have you tried setting the device block size to its sector size?
> 
>   blockdev --setbsz $(blockdev --getss /dev/...) /dev/...

If I understand correctly David is not reporting a problem, but
vaguely recalls that there was a problem in this area long ago,
and asks whet the current status is.

(Yes, today things are better, but not perfect yet :-))
