Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUBMKD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUBMKD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:03:28 -0500
Received: from [212.28.208.94] ([212.28.208.94]:51462 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266879AbUBMKDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:03:12 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Fri, 13 Feb 2004 11:03:10 +0100
User-Agent: KMail/1.6.1
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402131103.10366.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 03.29, you wrote:
> On Fri, Feb 13, 2004 at 02:16:53AM +0100, Robin Rosenberg wrote:
> > Yes, so ext3&co. should be equipped with charset options just the other so
> > it can be fixed by the user or in some cases the mount tools. 
> > 
> > Is there a place to store character set information in these file systems?
> 
> Bullshit.  Just as there is no timezone common for all users, there is no
> charset common for all of them.  Charset of _machine_ doesn't make any sense
> at all - toy operating systems nonwithstanding.

For us using toy languages, we see characters in filenames, not byte sequences, and
if whenever possible users should see the same name regardless of locale.

-- robin
