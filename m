Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267904AbTAMGUH>; Mon, 13 Jan 2003 01:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267913AbTAMGUH>; Mon, 13 Jan 2003 01:20:07 -0500
Received: from mail.somanetworks.com ([216.126.67.42]:5288 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S267904AbTAMGUG>; Mon, 13 Jan 2003 01:20:06 -0500
Date: Mon, 13 Jan 2003 01:28:51 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Greg KH <greg@kroah.com>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Grant Grundler <grundler@cup.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
In-Reply-To: <20030112071947.GA29841@kroah.com>
Message-ID: <Pine.LNX.4.44.0301130122580.9854-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003, Greg KH wrote:

> On Sat, Jan 11, 2003 at 02:39:47PM -0500, Scott Murray wrote:
> > 
> > Since the lack of resource reservation currently is keeping CompactPCI
> > hot insertion from working properly, I have a strong interest in getting
> > something in place before 2.6.  I've got a completely manual (kernel
> > command-line parameter controlled) reservation patch[1] against 2.4 that
> > I could start updating, but I've always thought there must be a more 
> > elegant way to do things than the somewhat crude fixup approach I used
> > in it.  I'm willing to try coding up something if you or anyone else
> > have some ideas as to what would be an acceptable solution.
> 
> Didn't people say that your reservation patch looked fine for 2.5?
> But that was a while ago, and you never sent it...  :)

I went through my archived mail, and you're absolutely right, I had just
totally forgotten about that discussion.  I'll try and cook up a version 
of my manual resource reservation patch against current 2.5 starting 
tomorrow.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

