Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUBRLHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUBRLHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:07:30 -0500
Received: from mail.shareable.org ([81.29.64.88]:32645 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264267AbUBRLH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:07:29 -0500
Date: Wed, 18 Feb 2004 11:06:48 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Hans Reiser <reiser@namesys.com>, Stefan Smietanowski <stesmi@stesmi.com>,
       Linus Torvalds <torvalds@osdl.org>, Marc Lehmann <pcg@schmorp.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040218110648.GF28599@mail.shareable.org>
References: <200402150107.26277.robin.rosenberg.lists@dewire.com> <40324741.4040707@stesmi.com> <4032BF78.70802@namesys.com> <200402180308.48354.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402180308.48354.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Rosenberg wrote:
> A character is the simplest form of image so it should always look the same.

People who need the computer to _speak_ names need language or
phonetic information attached to a name, for it to be spoken properly.

On this, Alex Belits has a good point.  It's all very well
standardising on UTF-8 so every name can be displayed nicely.  That is
incomplete for a user who needs "ls" to work audibly, though.

In practice, such a user configures their machine to assume a
particular language, or guess it with bias to the one they use most often.

That is, in some ways, the same problem as having a mixture of
filenames in an unknown character encoding, except that UTF-8 doesn't
solve it.

-- Jamie
