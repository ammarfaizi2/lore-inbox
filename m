Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131654AbRC1MvV>; Wed, 28 Mar 2001 07:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131777AbRC1MvM>; Wed, 28 Mar 2001 07:51:12 -0500
Received: from helena.mi.uni-erlangen.de ([131.188.103.20]:14786 "EHLO mi.uni-erlangen.de") by vger.kernel.org with ESMTP id <S131654AbRC1Mu6>; Wed, 28 Mar 2001 07:50:58 -0500
Date: Wed, 28 Mar 2001 14:50:06 +0200 (MEST)
From: Walter Hofmann <snwahofm@mi.uni-erlangen.de>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
In-Reply-To: <01032806093901.11349@tabby>
Message-ID: <Pine.GSO.3.96.1010328144551.7198A-100000@laertes>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Mar 2001, Jesse Pollard wrote:

> >Any idea?
> 
> Sure - very simple. If the execute bit is set on a file, don't allow
> ANY write to the file. This does modify the permission bits slightly
> but I don't think it is an unreasonable thing to have.

And how exactly does this help?

fchmod (fd, 0666);
fwrite (fd, ...);
fchmod (fd, 0777);

Walter

