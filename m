Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbREQL6K>; Thu, 17 May 2001 07:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261408AbREQL6A>; Thu, 17 May 2001 07:58:00 -0400
Received: from zeus.kernel.org ([209.10.41.242]:52188 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261407AbREQL5p>;
	Thu, 17 May 2001 07:57:45 -0400
Message-ID: <3B03B5F5.F9EC01D3@uow.edu.au>
Date: Thu, 17 May 2001 21:28:53 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mdaljeet@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: bindprocessor
In-Reply-To: <CA256A4F.003B5469.00@d73mta05.au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mdaljeet@in.ibm.com wrote:
> 
> How can I bind a user space process to a particular processor in  a SMP
> environment?

You can't.

Nick Pollitt had an implementation of prcctl() which does this
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0102.2/0214.html

I have a /proc based one at
http://www.uow.edu.au/~andrewm/linux/#cpus_allowed
