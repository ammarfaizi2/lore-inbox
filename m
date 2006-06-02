Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWFBFGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWFBFGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWFBFGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:06:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51155 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751122AbWFBFGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:06:53 -0400
Message-ID: <447FC75F.6090905@zytor.com>
Date: Thu, 01 Jun 2006 22:06:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2.6.16-rc5-mm2] i386 memcpy: optimal memcpy for IO
References: <200606012130_MC3-1-C15B-2A16@compuserve.com>
In-Reply-To: <200606012130_MC3-1-C15B-2A16@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> From: H. Peter Anvin <hpa@zytor.com>
> 
> Optimal memcpy for moves to/from IO space.  Does as few moves as
> possible while keeping transfers optimally aligned.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 

Why wrap this in C code when it's just assembly anyway?  It just makes 
it look ugly...

	-hpa
