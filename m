Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbUDHIKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 04:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbUDHIKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 04:10:31 -0400
Received: from mail.bytecamp.net ([212.204.60.9]:21764 "EHLO mail.bytecamp.net")
	by vger.kernel.org with ESMTP id S263973AbUDHIK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 04:10:27 -0400
Message-Id: <200404080810.i388AQqf081142@mail.bytecamp.net>
From: "Jan Kesten" <rwe.piller@the-hidden-realm.de>
To: linux-kernel@vger.kernel.org
Subject: Dynamic file 'swapping'
Date: Thu, 08 Apr 2004 10:10:26 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all! 

 

Don't know if it's a topic for the lkml, but I try ;-) 

 

I was wondering if for linux or better for a linux filesystem there is
something like dynamic swapping of files possible. For explanation: I habe
access to an Infinstor via NFS and linux is runnig there. This server has a
nice funtion I'd like to have: if there are files that are not used for a
specified time (i.e. 30 days) they are moved to another storage (disk and
after that to an streamer tape) and are replaced by some kind of 'link'. So
if you look at your directory you can see everything that was there, but if
you try to open it, you have to wait a moment (some seconds if the file was
swapped to another disk) oder just another moment (some minutes if the file
is on a tape) and then it restored at it's old place. 

 

So is there anything which provides such a feature? By now I have a little
script that moves such files out of the way and replaces them by links. But
restoring is somewhat harder and it's not automatic. 

 

Any ideas? 

Jan 


