Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267124AbUBRCJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267128AbUBRCJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:09:05 -0500
Received: from [212.28.208.94] ([212.28.208.94]:41739 "HELO dewire.com")
	by vger.kernel.org with SMTP id S267124AbUBRCJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:09:01 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Date: Wed, 18 Feb 2004 03:08:48 +0100
User-Agent: KMail/1.6.1
Cc: Stefan Smietanowski <stesmi@stesmi.com>,
       Linus Torvalds <torvalds@osdl.org>, Marc Lehmann <pcg@schmorp.de>,
       Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <200402150107.26277.robin.rosenberg.lists@dewire.com> <40324741.4040707@stesmi.com> <4032BF78.70802@namesys.com>
In-Reply-To: <4032BF78.70802@namesys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402180308.48354.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 February 2004 02.27, Hans Reiser wrote:
> ReiserFS 6 plans to allow files to be associated with arbitrary files 
> and found by those associations.  Some of those files will consist of 
> ascii keywords, some will be icon images, etc.....  Human readability 
> should not be considered fundamental to a name component, especially 
> since programs with no interest in readability may be the only direct 
> users of the name.

If the user never sees a name, it doesn't matter. However the user actually sees
and reads the filenames in /home, portable media, networks devices and lots of
places. However, when a user has named a component those characters are those
that are important to the user because those form an "image" (since you introduced
the term) or "sound" that the user remembers and associates with the content. A 
character is the simplest form of image so it should always look the same.

-- robin
