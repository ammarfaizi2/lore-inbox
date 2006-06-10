Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWFJDLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWFJDLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 23:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWFJDLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 23:11:41 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:13487 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750721AbWFJDLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 23:11:40 -0400
Message-ID: <448A3863.3060906@garzik.org>
Date: Fri, 09 Jun 2006 23:11:31 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org> <448A1BBA.1030103@garzik.org> <20060610013048.GS5964@schatzie.adilger.int> <448A23B2.5080004@garzik.org> <20060610020306.GA449@thunk.org> <448A2A6F.8020301@garzik.org> <20060610025424.GA8536@thunk.org>
In-Reply-To: <20060610025424.GA8536@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> And this is your argument that on-line resizing is a horrible hack,

It's an example of ext2 being bandaided to do something it was never 
originally designed to do.  If online resizing had been planned from the 
start, allocating new inode tables on the fly would be trivial, as it is 
in JFS/NTFS/...


> and ext3 should be thrown out and rewritten from scratch? 

Blatant and silly exaggeration.  Re-read the thread, and note how many 
times "cp -a ext3 ext4" was written.

	Jeff



