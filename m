Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263778AbREYPuS>; Fri, 25 May 2001 11:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263780AbREYPuK>; Fri, 25 May 2001 11:50:10 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:28167 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263778AbREYPuB>;
	Fri, 25 May 2001 11:50:01 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8 
In-Reply-To: Your message of "Fri, 25 May 2001 08:31:24 MST."
             <Pine.LNX.4.33.0105250821210.30357-100000@twinlark.arctic.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 26 May 2001 01:49:55 +1000
Message-ID: <1917.990805795@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001 08:31:24 -0700 (PDT), 
dean gaudet <dean-list-linux-kernel@arctic.org> wrote:
>another possibility for a debugging mode for the kernel would be to hack
>gcc to emit something like the following in the prologue of every function
>(after the frame is allocated):

IKD already does that, via the CONFIG_DEBUG_KSTACK, CONFIG_KSTACK_METER
and CONFIG_KSTACK_THRESHOLD options.  No need to hack gcc.

