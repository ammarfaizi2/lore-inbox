Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318291AbSIKCaW>; Tue, 10 Sep 2002 22:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSIKCaW>; Tue, 10 Sep 2002 22:30:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37510 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318291AbSIKCaT>;
	Tue, 10 Sep 2002 22:30:19 -0400
Date: Tue, 10 Sep 2002 22:35:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rick Lindsley <ricklind@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 gendisk changes
In-Reply-To: <200209110209.g8B298D00202@eng4.beaverton.ibm.com>
Message-ID: <Pine.GSO.4.21.0209102234280.6397-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Sep 2002, Rick Lindsley wrote:

> It would seem that in 2.5.34 gendisk->part[0] no longer refers to the
> whole disk, but instead refers to the first partition.  Is this
> correct? There isn't a struct hd_struct that refers to the whole disk
> anymore?
> 
> I'm working on porting forward the sard patch for disk statistics, so I
> want to make sure this is the intent and not an off-by-one bug. Other
> code, though, suggests it's intentional.

It is intentional.

