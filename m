Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311267AbSCQCus>; Sat, 16 Mar 2002 21:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311268AbSCQCui>; Sat, 16 Mar 2002 21:50:38 -0500
Received: from tapu.f00f.org ([66.60.186.129]:5285 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S311263AbSCQCuS>;
	Sat, 16 Mar 2002 21:50:18 -0500
Date: Sat, 16 Mar 2002 18:50:04 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: yodaiken@fsmlabs.com, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020317025004.GA13644@tapu.f00f.org>
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com.suse.lists.linux.kernel> <20020316115726.B19495@hq.fsmlabs.com.suse.lists.linux.kernel> <p73g0301f79.fsf@oldwotan.suse.de> <20020316125711.B20436@hq.fsmlabs.com> <20020316210504.A24097@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020316210504.A24097@wotan.suse.de>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 09:05:04PM +0100, Andi Kleen wrote:

    On Sat, Mar 16, 2002 at 12:57:11PM -0700, yodaiken@fsmlabs.com
    wrote:

    >
    > What about 2M pages?

    They are not supported for user space, but used in private
    mappings for kernel text and direct memory mappings. Generic code
    never sees them.

Is there any reason we couldn't use them for mapping large
frame-buffers and similar?



  --cw
