Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRBMVGp>; Tue, 13 Feb 2001 16:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130228AbRBMVGg>; Tue, 13 Feb 2001 16:06:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46347 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129211AbRBMVGc>; Tue, 13 Feb 2001 16:06:32 -0500
Subject: Re: Is this the ultimate stack-smash fix?
To: jeremy.jackson@sympatico.ca (Jeremy Jackson)
Date: Tue, 13 Feb 2001 21:06:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca> from "Jeremy Jackson" at Feb 13, 2001 03:58:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SmeD-0002sR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which are marked
> supervisor-only (is this right?), and definitely don't contain user
> code.

x86 its a fair description. However someone has taken the same theory, 
including handling the exceptions and the x86 segment tricks needed to make
it kind of fly. Its not a perfect cure but it works. Search for Solar Designer
and non executable stack.




