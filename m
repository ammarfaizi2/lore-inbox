Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270472AbRHNHHr>; Tue, 14 Aug 2001 03:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270473AbRHNHHh>; Tue, 14 Aug 2001 03:07:37 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:61843 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S270472AbRHNHH1>; Tue, 14 Aug 2001 03:07:27 -0400
Date: Tue, 14 Aug 2001 08:07:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rich Baum <richbaum@acm.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] fix 2.4.8 compile errors
Message-ID: <20010814080730.A23065@flint.arm.linux.org.uk>
In-Reply-To: <100C620A6B75@coral.indstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <100C620A6B75@coral.indstate.edu>; from richbaum@acm.org on Mon, Aug 13, 2001 at 09:47:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2001 at 09:47:28PM -0500, Rich Baum wrote:
> This patch fixes two compile errors I get when compiling 2.4.8 on my K6-2.  
> Both of these errors are caused by compiling drivers for other architectures. 
>  I've changed the Config.in files to keep these options from being selected 
> on the wrong architecture.

Both of these look wrong from the if...fi point of view.  Please ensure
that all if's you add have a corresponding fi statement.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

