Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbTENCPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 22:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTENCPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 22:15:21 -0400
Received: from holomorphy.com ([66.224.33.161]:44223 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263750AbTENCPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 22:15:20 -0400
Date: Tue, 13 May 2003 19:27:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Shawn <core@enodev.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: odd db4 error with 2.5.69-mm4 [was Re: Huraaa for 2.5]
Message-ID: <20030514022759.GJ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Shawn <core@enodev.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>
References: <1052866461.23191.4.camel@www.enodev.com> <20030514012731.GF8978@holomorphy.com> <1052877161.3569.17.camel@www.enodev.com> <20030514021826.GI8978@holomorphy.com> <1052879063.3569.31.camel@www.enodev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052879063.3569.31.camel@www.enodev.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 21:18, William Lee Irwin III wrote:
>> They appear to either not be running in equivalent environments or
>> something has gone horribly wrong. The diff is incredibly noisy and not
>> useful for debugging, could you strace the working kernel's bit as root?
>> Also, things start getting wildly different after both examine DB_CONFIG,
>> where 2.4 and 2.5 open different files with different options, i.e. 2.5
>> does O_DIRECT on /var/lib/rpm/__db.001 and 2.4 never touches that file,
>> and 2.4 never does O_DIRECT either.
>> This may very well have something to do with the difference in
>> privileges.

On Tue, May 13, 2003 at 09:24:23PM -0500, Shawn wrote:
> Thanks for all the help! So, is it that there is likely misuse of
> O_DIRECT somewhere (db4, rpm, etc)?
> Wonder if I should bother filing a bug if rpm has a bugzilla...

My sources say the bug is in the packaged version of db4.


-- wli
