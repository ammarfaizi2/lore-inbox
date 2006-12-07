Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936947AbWLGOai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936947AbWLGOai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937957AbWLGOai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:30:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58567 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936947AbWLGOag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:30:36 -0500
From: Andreas Schwab <schwab@suse.de>
To: Theodore Tso <tytso@mit.edu>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux should define ENOTSUP
References: <20061206135134.GJ3927@implementation.labri.fr>
	<1165415115.3233.449.camel@laptopd505.fenrus.org>
	<20061206143159.GP3927@implementation.labri.fr>
	<20061207134914.GB31773@thunk.org> <je7ix3bycr.fsf@sykes.suse.de>
	<20061207141542.GD31773@thunk.org>
X-Yow: The fact that 47 PEOPLE are yelling and sweat is cascading
 down my SPINAL COLUMN is fairly enjoyable!!
Date: Thu, 07 Dec 2006 15:30:33 +0100
In-Reply-To: <20061207141542.GD31773@thunk.org> (Theodore Tso's message of
	"Thu, 7 Dec 2006 09:15:42 -0500")
Message-ID: <jezm9zaid2.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso <tytso@mit.edu> writes:

> On Thu, Dec 07, 2006 at 02:59:48PM +0100, Andreas Schwab wrote:
>> Theodore Tso <tytso@mit.edu> writes:
>> 
>> > Can you please quote chapter and verse (in POSIX) where it states that
>> > ENOTSUP and EOPNOTSUP have to be numerically distinct?
>> 
>> <http://www.opengroup.org/onlinepubs/009695399/basedefs/errno.h.html>
>> "Their values shall be unique except as noted below."
>> (And there is no exception for ENOTSUP/EOPNOTSUP yet.)
>
> Ah, but you're quoting from SuS, not POSIX.  (Yes, I'm splitting
> hairs, but that's what standards are all about.  :-)

The quoted sentence is not shaded as an XSI extension, thus it is part of
POSIX-1:2001.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
