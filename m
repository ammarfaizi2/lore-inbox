Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWEBPZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWEBPZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWEBPZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:25:58 -0400
Received: from smtpout.mac.com ([17.250.248.173]:13274 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964881AbWEBPZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:25:57 -0400
In-Reply-To: <20060502151525.GX27946@ftp.linux.org.uk>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502133416.GT27946@ftp.linux.org.uk> <4457668F.8080605@argo.co.il> <20060502143430.GW27946@ftp.linux.org.uk> <445774F7.5030106@argo.co.il> <20060502151525.GX27946@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E1DB2E39-1AAC-4DEB-A595-EDE6B138ED3C@mac.com>
Cc: Avi Kivity <avi@argo.co.il>, Willy Tarreau <willy@w.ods.org>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Compiling C++ modules
Date: Tue, 2 May 2006 11:24:52 -0400
To: Al Viro <viro@ftp.linux.org.uk>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 2, 2006, at 11:15:25, Al Viro wrote:
> On Tue, May 02, 2006 at 06:04:23PM +0300, Avi Kivity wrote:
>> BTW, C++ could take over some of sparse's function:
>
> And the point of that would be?  sparse is _fast_ and easy to  
> modify; g++ is neither.

For example; you can run _both_ a full sparse with all checks _and_  
"gcc -Wall -Wextra -Werror -g -O2" in less time than it takes to  
_just_ run "g++ -O0" on a nearly identical file.  If you have some  
new typechecking to do, figure out how to add it to sparse without  
cluttering up the syntax, don't convert the thing to C++, slow down  
the compile, etc.

Cheers,
Kyle Moffett


