Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSIKGBZ>; Wed, 11 Sep 2002 02:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSIKGBZ>; Wed, 11 Sep 2002 02:01:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26007 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318348AbSIKGBZ>; Wed, 11 Sep 2002 02:01:25 -0400
Message-Id: <200209110605.g8B65VD02658@eng4.beaverton.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 gendisk changes 
In-reply-to: Your message of "Tue, 10 Sep 2002 22:35:05 EDT."
             <Pine.GSO.4.21.0209102234280.6397-100000@weyl.math.psu.edu> 
Date: Tue, 10 Sep 2002 23:05:31 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

    It would seem that in 2.5.34 gendisk->part[0] no longer refers to the
    whole disk, but instead refers to the first partition.  Is this
    correct? There isn't a struct hd_struct that refers to the whole disk
    anymore?
    
    I'm working on porting forward the sard patch for disk statistics, so I
    want to make sure this is the intent and not an off-by-one bug. Other
    code, though, suggests it's intentional.
    
Alexander Viro replied:

    It is intentional.
    
Great -- that helps.  Is there an hd_struct for the whole disk anymore?
Are there additional changes forthcoming, or is this the extent of the
gendisk changes?

Rick
