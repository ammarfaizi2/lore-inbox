Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032247AbWLGOPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032247AbWLGOPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032249AbWLGOPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:15:51 -0500
Received: from thunk.org ([69.25.196.29]:42201 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032247AbWLGOPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:15:50 -0500
Date: Thu, 7 Dec 2006 09:15:42 -0500
From: Theodore Tso <tytso@mit.edu>
To: Andreas Schwab <schwab@suse.de>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux should define ENOTSUP
Message-ID: <20061207141542.GD31773@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andreas Schwab <schwab@suse.de>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20061206135134.GJ3927@implementation.labri.fr> <1165415115.3233.449.camel@laptopd505.fenrus.org> <20061206143159.GP3927@implementation.labri.fr> <20061207134914.GB31773@thunk.org> <je7ix3bycr.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <je7ix3bycr.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 02:59:48PM +0100, Andreas Schwab wrote:
> Theodore Tso <tytso@mit.edu> writes:
> 
> > Can you please quote chapter and verse (in POSIX) where it states that
> > ENOTSUP and EOPNOTSUP have to be numerically distinct?
> 
> <http://www.opengroup.org/onlinepubs/009695399/basedefs/errno.h.html>
> "Their values shall be unique except as noted below."
> (And there is no exception for ENOTSUP/EOPNOTSUP yet.)

Ah, but you're quoting from SuS, not POSIX.  (Yes, I'm splitting
hairs, but that's what standards are all about.  :-)

						- Ted
