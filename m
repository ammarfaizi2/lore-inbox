Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262720AbREVSqU>; Tue, 22 May 2001 14:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262718AbREVSqK>; Tue, 22 May 2001 14:46:10 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41110 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262716AbREVSqC>;
	Tue, 22 May 2001 14:46:02 -0400
Date: Tue, 22 May 2001 20:45:20 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105221845.UAA78949.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, bcrl@redhat.com, phillips@bonn-fries.net
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in userspace
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What is the communication between user space and kernel
>> that transports device identities?

> It doesn't change, the same symbolic names still work.

But today, unless you think of devfs or so, device identities
are not transported by symbolic names. They are given by
device numbers.

[Yes, symbolic names have a certain secondary role, e.g. in error
messages, or perhaps to indicate the boot device.]

Andries
