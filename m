Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266537AbUBQUlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUBQUjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:39:17 -0500
Received: from [212.28.208.94] ([212.28.208.94]:26378 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266537AbUBQUhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:37:42 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Date: Tue, 17 Feb 2004 21:37:40 +0100
User-Agent: KMail/1.6.1
Cc: Marc Lehmann <pcg@schmorp.de>, Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <200402150107.26277.robin.rosenberg.lists@dewire.com> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402172137.40376.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 17.32, Linus Torvalds wrote:
> 
> On Tue, 17 Feb 2004, Marc Lehmann wrote:
> > 
> > Because there is a fundamental difference between file contents and
> > filenames. Filenames are supposed to be text.
> 
> I think this is actually the fundamental point where we disagree.
> 
> You think of filenames as something the user types in, and that is 
> "readable text". And I don't.
> 
> I think the filenames are just ways for a _program_ to look up stuff, and
> the human readability is a secondary thing (it's "polite", but not a
> fundamental part of their meaning).

So why don't we use an int as "filename" and why are users to "type" in
filenames? How foolish...

-- robin
