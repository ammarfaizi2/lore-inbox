Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267928AbSIRTxg>; Wed, 18 Sep 2002 15:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267995AbSIRTxg>; Wed, 18 Sep 2002 15:53:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:12703 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267928AbSIRTxg>; Wed, 18 Sep 2002 15:53:36 -0400
Date: Wed, 18 Sep 2002 12:53:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Cort Dougan <cort@fsmlabs.com>, Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <142420000.1032378823@flay>
In-Reply-To: <Pine.LNX.4.44.0209182026300.25598-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209182026300.25598-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Nobody's trying to screw the desktop users, we're being mind- bogglingly
>> careful not to, in fact. If you have specific objections to a particular
>> patch, raise them as technical arguments. Saying "we shouldn't do that
>> because I'm not interested in it" is far less useful.
> 
> i fully agree with your points, but it does not hold in this specific
> case. Eliminating for_each_task loops (the ones completely unrelated to
> the get_pid() issue) is an improvement even for desktop setups, which have
> at most 1000 processes running.

Right - which is exactly why I was saying we should stick to technical 
debates rather than whether some people were interested in a particular
market segment or not ;-)

M.

