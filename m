Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUEFVro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUEFVro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUEFVro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:47:44 -0400
Received: from emess.mscd.edu ([147.153.170.17]:7116 "EHLO emess.mscd.edu")
	by vger.kernel.org with ESMTP id S263095AbUEFVrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:47:42 -0400
From: Steve Beaty <beaty@emess.mscd.edu>
Message-Id: <200405062147.i46LlI9t017827@emess.mscd.edu>
Subject: Re: sigaction, fork, malloc, and futex
To: froese@gmx.de (Edgar Toernig)
Date: Thu, 6 May 2004 15:47:18 -0600 (MDT)
Cc: beaty@emess.mscd.edu (Steve Beaty), linux-kernel@vger.kernel.org
In-Reply-To: <20040505023852.509f5fe3.froese@gmx.de> from "Edgar Toernig" at May 05, 2004 02:38:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uhh... just read that POSIX actually allows that.  Evil!
> I guess you're entering undiscovered land...

	it's funny how often i am there :-) :-)

> No fprintf and exit in a signal handler!  Use write and _exit instead.

	doesn't seem to matter...

> This exit is dubious too.  _exit is better.

	nor does this...  i know better than to use *printf and exit; i was
	eager to get other's views on this...

> Good luck, you may need it - ET.

	i do! :-)  the code seems to work on Ultrix, Solaris, and OSX.
	this doesn't imply that it should :-)

-- 
Dr. Steve Beaty (B80)                                 Associate Professor
Metro State College of Denver                        beaty@emess.mscd.edu
VOX: (303) 556-5321                                 Science Building 134C
FAX: (303) 556-5381                         http://clem.mscd.edu/~beatys/
