Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbRDBXLv>; Mon, 2 Apr 2001 19:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbRDBXLl>; Mon, 2 Apr 2001 19:11:41 -0400
Received: from blackhole.compendium-tech.com ([206.55.153.26]:40953 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S131477AbRDBXL0>; Mon, 2 Apr 2001 19:11:26 -0400
Date: Mon, 2 Apr 2001 16:10:06 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: Shawn Starr <spstarr@sh0n.net>, Matti Aarnio <matti.aarnio@zmailer.org>,
   <linux-kernel@vger.kernel.org>
Subject: Re: Disturbing news..
In-Reply-To: <01032806093901.11349@tabby>
Message-ID: <Pine.LNX.4.30.0104021608090.29684-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2001, Jesse Pollard wrote:
> Sure - very simple. If the execute bit is set on a file, don't allow
> ANY write to the file. This does modify the permission bits slightly
> but I don't think it is an unreasonable thing to have.

Oh, honestly! Think about what you are saying here:

What if you are developing something in an interpereted language such as
perl or a shell script, where you *directly modify the executable file*?

No, this won't work...Not wwithout being annoying as hell.

