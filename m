Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290379AbSAXWHC>; Thu, 24 Jan 2002 17:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290380AbSAXWGx>; Thu, 24 Jan 2002 17:06:53 -0500
Received: from ucrwcu.rwc.uc.edu ([129.137.3.94]:4536 "EHLO ucrwcu.rwc.uc.edu")
	by vger.kernel.org with ESMTP id <S290379AbSAXWGk>;
	Thu, 24 Jan 2002 17:06:40 -0500
Message-ID: <3C508600.25AF021@ucrwcu.rwc.uc.edu>
Date: Thu, 24 Jan 2002 17:09:04 -0500
From: ken <koehlekr@ucrwcu.rwc.uc.edu>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 multiple Oops and file corruption on I845 MB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

Well, I guess I'm not the only one who has ever had egg on his face
after posting a bug report.

Before posting the report, I had run memtest86 v2.5.1 for more than one
complete pass of the std tests and had concluded the memory was OK.  On
a hunch, after a reply from Mark Hahn, I let it run all night; after 17
hours running all tests over 3+ passes, it recorded about 4000 errors.
These were clustered around 64MB and 135MB (64K and 4K holes,
respectively), and I think that adequately accounts for the problems I
was having on large file copies.  The guy who sold me the hardware took
it all back and refunded my money rather than having to learn something
about linux, so I guess he didn't deserve the sale after all.

Thanks again to all who read and responded. Now I know to run multiple
passes on memtest before deciding things are OK....

Ken
