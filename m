Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293253AbSBWXHf>; Sat, 23 Feb 2002 18:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293254AbSBWXHZ>; Sat, 23 Feb 2002 18:07:25 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7668
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293253AbSBWXHU>; Sat, 23 Feb 2002 18:07:20 -0500
Date: Sat, 23 Feb 2002 15:07:55 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Stephen Lord <lord@sgi.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020223230755.GO20060@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Stephen Lord <lord@sgi.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au> <3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au> <3C781362.7070103@sgi.com> <3C781909.F69D8791@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C781909.F69D8791@zip.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 02:34:49PM -0800, Andrew Morton wrote:
> Unfortunately I seem to have found a bug in existing ext2, a bug
> in existing block_write_full_page, a probable bug in the aic7xxx
> driver, and an oops in the aic7xxx driver.  So progress has slowed
> down a bit :(

Are these bugs in 2.4 also?

