Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278101AbRJKFRz>; Thu, 11 Oct 2001 01:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278100AbRJKFRp>; Thu, 11 Oct 2001 01:17:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6207 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S278099AbRJKFR1>; Thu, 11 Oct 2001 01:17:27 -0400
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Doug McNaught <doug@wireboard.com>,
        Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com>
	<m3elob3xao.fsf@belphigor.mcnaught.org>
	<20011010173811.C3795@mikef-linux.matchmail.com>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 10 Oct 2001 23:07:42 -0600
In-Reply-To: <20011010173811.C3795@mikef-linux.matchmail.com>
Message-ID: <m1lmiivk69.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> IIRC, 2.2 didn't have a coherent buffer and page cache also.
> 
> I.E. if you "cat /dev/hda > /dev/null" you wouldn't be able to expect any
> speedup when reading through the mounted filesystem (except for meta-data?).
> 
> Am I wrong?  Has Linux ever had a coherent page and buffer cache?

In 2.2 all writes went through the buffer cache.  So for the buffer cache
was coherent with the filesystem but the filesystem wasn't coherent with the
buffer cache.

Eric
