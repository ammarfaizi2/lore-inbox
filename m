Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTF2Tln (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTF2Tlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:41:36 -0400
Received: from oak.sktc.net ([64.71.97.14]:21981 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S264235AbTF2Tlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:41:32 -0400
Message-ID: <3EFF4443.8080507@sktc.net>
Date: Sun, 29 Jun 2003 14:55:47 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rmoser <mlmoser@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net> <200306291431080580.01CF24BF@smtp.comcast.net>
In-Reply-To: <200306291431080580.01CF24BF@smtp.comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmoser wrote:

> Ass yourself for hours, each time risking making a typo and killing both
> filesystems, or risking having the LVM resize die from a powerdrop or a kick
> to the power button (sorry we don't all have immortal fault tolerance).  I actually
> though about this one and figured it was too rediculously annoying to actually
> bring up :-p
> 

> I've never used LVM, but I'll look at it one day.  If it's stable, that's good; I
> don't use Windows.  I don't know exactly what LVM is but I have a pretty
> good idea; it's been forever since I read the doc on it, I forgot what it said!
> 


Funny how, having never used LVM you have an opinion about it.

I have. I have done EXACTLY what I described.

First of all, do you REALLY think my way is any less failure prone, 
especially in the presence of the possiblilty of power failure than any 
other method? My method preserves a mountable, valid file system at each 
step of the way - the resized downward of the old file system, the 
resize upward of the new, the file copy.

Secondly, if you are REALLY concerned about the manual aspect of what I 
suggested, you can write a simple shell script to do the work.

Third of all, the longest parts of the process I describe will be the 
resize downward of the old file system and the copy of the data - the 
LVM parts of this operation are pretty damn quick.

