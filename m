Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281283AbRKETFu>; Mon, 5 Nov 2001 14:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281282AbRKETFk>; Mon, 5 Nov 2001 14:05:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9276 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281281AbRKETFa>; Mon, 5 Nov 2001 14:05:30 -0500
Date: Mon, 5 Nov 2001 20:05:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification
Message-ID: <20011105200530.G18319@athlon.random>
In-Reply-To: <20011105175337.D18319@athlon.random> <200111052018.PAA03082@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200111052018.PAA03082@ccure.karaya.com>; from jdike@karaya.com on Mon, Nov 05, 2001 at 03:18:42PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 03:18:42PM -0500, Jeff Dike wrote:
> eliminating caching as much as possible.  If the metadata/data ratio is
> small, then the metadata caching probably won't be noticable.

yes, of course the metadata/data ratio is very small, O_DIRECT isn't
slower than rawio infact (assuming the file isn't fragmented).

Andrea
