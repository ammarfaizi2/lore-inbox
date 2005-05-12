Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVELPyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVELPyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 11:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVELPyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 11:54:36 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:45274 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262012AbVELPy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 11:54:29 -0400
Message-ID: <42837C2E.9000506@nortel.com>
Date: Thu, 12 May 2005 09:54:22 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Need kernel patch to compile with Intel compiler
References: <377362e105051207461ff85b87@mail.gmail.com> <Pine.LNX.4.61.0505121130030.31719@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0505121130030.31719@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> The kernel is designed to be compiled with the GNU 'C' compler
> supplied with every distribution. It uses a lot of __asm__()
> statements and other GNU-specific constructions.

Yep.  And Intel added a bunch of them to their compiler so that they 
could build a kernel with it.

> Why would you even attempt to convert the kernel sources to
> be compiled with some other tools?

The Intel compiler is quite good at optimizing for their processors (and 
ironically for AMD ones as well).  However, I think that a lot of the 
gains come from the vectorizer, which of course can't be used with 
kernel code.

Chris
