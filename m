Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTANReX>; Tue, 14 Jan 2003 12:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTANReX>; Tue, 14 Jan 2003 12:34:23 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:49554 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264844AbTANReW>;
	Tue, 14 Jan 2003 12:34:22 -0500
Date: Tue, 14 Jan 2003 17:40:03 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Christoph Hellwig <hch@lst.de>,
       Hugh Dickins <hugh@veritas.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
Message-ID: <20030114174003.GB9469@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Tigran Aivazian <tigran@veritas.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Hugh Dickins <hugh@veritas.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <1042563017.1401.2.camel@laptop.fenrus.com> <Pine.LNX.4.33.0301141726280.1241-100000@einstein31.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301141726280.1241-100000@einstein31.homenet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 05:29:58PM +0000, Tigran Aivazian wrote:

 > No, because cat is using 4K chunks and the data has to be written in one
 > large chunk, like this:
 > 
 > # dd if=microcode of=/dev/cpu/microcode bs=141312 count=1
 > 
 > This actually works fine but you need to convert microcode data from human
 > readable (what Intel distribute) to binary format first. Easily done with
 > microcode_ctl utility.

What about the dumps Christian Ludhoff put at ftp.sandpile.org/mcupdate ?
These are binary data, but are they in the right format to be used ?
I'm curious if these are newer than the ones described in microcode.dat,
but haven't had time to dig through the dates on them.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
