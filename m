Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267074AbRGJSo0>; Tue, 10 Jul 2001 14:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbRGJSoH>; Tue, 10 Jul 2001 14:44:07 -0400
Received: from weta.f00f.org ([203.167.249.89]:49282 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267074AbRGJSoB>;
	Tue, 10 Jul 2001 14:44:01 -0400
Date: Wed, 11 Jul 2001 06:43:55 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, ttabi@interactivesi.com,
        linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Message-ID: <20010711064355.F32421@weta.f00f.org>
In-Reply-To: <200107101812.NAA01171@tomcat.admin.navo.hpc.mil> <3B4B4966.996DD91E@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4B4966.996DD91E@didntduck.org>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 02:28:54PM -0400, Brian Gerst wrote:

    Jesse Pollard wrote:

        > If the entire page table were given to a user, then a full cache
        > flush would have to be done on every context switch and system
        > call. That would be very slow, but would allow a full 4G address
        > for the user.

    A full cache flush would be needed at every entry into the kernel,
    including hardware interrupts.  Very poor for performance.

Why would a cache flush be necessary at all? I assume ia32 caches
where physically not virtually mapped?




   --cw
