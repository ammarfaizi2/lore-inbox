Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWFJCcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWFJCcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 22:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWFJCcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 22:32:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31150 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932362AbWFJCcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 22:32:11 -0400
Message-ID: <448A2F1D.3030806@garzik.org>
Date: Fri, 09 Jun 2006 22:31:57 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org> <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org> <448A1BBA.1030103@garzik.org> <20060610013048.GS5964@schatzie.adilger.int> <448A23B2.5080004@garzik.org> <20060610022648.GV5964@schatzie.adilger.int>
In-Reply-To: <20060610022648.GV5964@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> the inode count per group
> is a fixed parameter for the whole filesystem that even online resizing
> cannot change.

Correct.  Fixed... at mke2fs time.  Thus, with varying mke2fs runs, 
inodes-per-group can vary, where it does not with online resize.

	Jeff




