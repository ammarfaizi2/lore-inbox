Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbRESIKo>; Sat, 19 May 2001 04:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbRESIKe>; Sat, 19 May 2001 04:10:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2509 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261687AbRESIK2>;
	Sat, 19 May 2001 04:10:28 -0400
Date: Sat, 19 May 2001 04:10:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ben LaHaise <bcrl@redhat.com>
cc: Andrew Clausen <clausen@gnu.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <Pine.LNX.4.33.0105190350080.13165-100000@devserv.devel.redhat.com>
Message-ID: <Pine.GSO.4.21.0105190405180.3724-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Ben LaHaise wrote:

> It's not done yet, but similar techniques would be applied.  I envision
> that a raid device would support operations such as
> open("/dev/md0/slot=5,hot-add=/dev/sda")

Think for a moment and you'll see why it's not only ugly as hell, but simply
won't work.

