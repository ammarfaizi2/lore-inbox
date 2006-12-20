Return-Path: <linux-kernel-owner+w=401wt.eu-S1030354AbWLTUMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWLTUMu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWLTUMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:12:50 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:49302 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030350AbWLTUMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:12:49 -0500
Date: Wed, 20 Dec 2006 21:12:48 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
In-Reply-To: <20061220195458.GH17561@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612202109170.9533@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0612201732040.6115@artax.karlin.mff.cuni.cz>
 <E1Gx4dv-00058S-00@dorka.pomaz.szeredi.hu> <20061220195458.GH17561@ftp.linux.org.uk>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Al Viro wrote:

> On Wed, Dec 20, 2006 at 05:50:11PM +0100, Miklos Szeredi wrote:
>> I don't see any problems with changing struct kstat.  There would be
>> reservations against changing inode.i_ino though.
>>
>> So filesystems that have 64bit inodes will need a specialized
>> getattr() method instead of generic_fillattr().
>
> And they are already free to do so.  And no, struct kstat doesn't need
> to be changed - it has u64 ino already.

I see, I should have checked recent kernel.

Mikulas
