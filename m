Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSLBUFA>; Mon, 2 Dec 2002 15:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSLBUFA>; Mon, 2 Dec 2002 15:05:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:33716 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264920AbSLBUE7>; Mon, 2 Dec 2002 15:04:59 -0500
Date: Mon, 02 Dec 2002 12:20:55 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Till Immanuel Patzschke <tip@inw.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
cc: lse-tech@lists.sourceforge.net
Subject: Re: [Q] Which kernel + special patches ???
Message-ID: <30790000.1038860455@w-hlinder>
In-Reply-To: <3DE5D2AD.72686009@inw.de>
References: <3DE5D2AD.72686009@inw.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, November 28, 2002 12:24:14 AM -0800 Till Immanuel Patzschke 
<tip@inw.de> wrote:

> Given an SMP system with many thousand processes and a potentially high
> network and IO load, what is the best combination of source and patch, to
> make best use of SMP, keep load low and throughput high?

Hello Till,

	This is a great question to ask on the Linux Scalability
mailing list: lse-tech@lists.sourceforge.net. We are devoted to
helping make Linux scale to large systems. Check out our work
at:

http://lse.sourceforge.net
http://sourceforge.net/projects/lse

>
> Is it 2.4.x + rmap or aa or O(1) or ac or some combination
> OR ist it 2.5.x + one (or more) of the above patches ???

In my opinion 2.5 has more new functionality for scalability and
increased performance than 2.4 does right now. Since 2.5 is the
development kernel for new features and 2.4 is the stable series.
Expect to see backports of the best 2.5 features to 2.4 after they
have proven themselves.

Please let us know the results of running on your very large systems.

Hanna Linder
IBM Linux Technology Center

