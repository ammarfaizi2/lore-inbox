Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTKMW1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 17:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTKMW1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 17:27:52 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39948
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264451AbTKMW1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 17:27:50 -0500
Date: Thu, 13 Nov 2003 14:27:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mary Edie Meredith <maryedie@osdl.org>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, jenny@osdl.org
Subject: Re: Nick's scheduler v18
Message-ID: <20031113222751.GJ2014@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Mary Edie Meredith <maryedie@osdl.org>, piggin@cyberone.com.au,
	linux-kernel@vger.kernel.org, jenny@osdl.org
References: <3FAFC8C6.8010709@cyberone.com.au> <1068746827.1750.1358.camel@ibm-e.pdx.osdl.net> <20031113113906.65431b18.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113113906.65431b18.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 11:39:06AM -0800, Andrew Morton wrote:
> What filesystem was being used?
> 
> If it was ext2 then perhaps you hit the recently-fixed block allocator
> race.  That fix was merged after test9.  Please check the kernel logs for
> any filesystem error messages.
> 
> Also, please retry the run, see if it is repeatable.

Did that hit ext3 also?  ISTR, getting some "access beyond end of device"
while running ext3.

Interestingly enough, I didn't get this while using reiserfs3...

And me still running 2.6.0-test6-mm4 :-/
