Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266328AbUBQQzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266332AbUBQQzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:55:05 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:30386 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S266328AbUBQQyl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:54:41 -0500
Message-ID: <40324741.4040707@stesmi.com>
Date: Tue, 17 Feb 2004 17:54:25 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Marc Lehmann <pcg@schmorp.de>, Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

>>Because there is a fundamental difference between file contents and
>>filenames. Filenames are supposed to be text.
> 
> I think this is actually the fundamental point where we disagree.
> 
> You think of filenames as something the user types in, and that is 
> "readable text". And I don't.
> 
> I think the filenames are just ways for a _program_ to look up stuff, and
> the human readability is a secondary thing (it's "polite", but not a
> fundamental part of their meaning).
> 
> So the same way I think text is good in config files and I dislike binary
> blobs (hey, look at /proc), I think readable filenames are good. But that
> doesn't mean that they have to be readable. I can well imagine encoding
> meta-data in the filename for some database that uses the filesystem as
> its backing store and generates files for large blobs. And then there
> would be little if any "goodness" to keeping the filenames readable.

Just look at Mozilla's cache... They may have turned the blob into
ascii but it's still a blob.

// Stefan

