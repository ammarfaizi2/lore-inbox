Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276653AbRJKSRm>; Thu, 11 Oct 2001 14:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276654AbRJKSRd>; Thu, 11 Oct 2001 14:17:33 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:59574 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S276653AbRJKSRZ>; Thu, 11 Oct 2001 14:17:25 -0400
Message-ID: <3BC5E29D.988466F6@nortelnetworks.com>
Date: Thu, 11 Oct 2001 14:19:09 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unkillable process in R state?
In-Reply-To: <Pine.SOL.4.33.0110111645410.18253-100000@yellow.csi.cam.ac.uk> <3BC5CD56.2E69C578@nortelnetworks.com> <20011011192520.A27394@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> 
> On Thu, Oct 11, 2001 at 12:48:22PM -0400, Christopher Friesen wrote:
> 
> > I have a process (an instance of a find command) that seems to be
> > unkillable (ie kill -9 <pid> as root doesn't work).
> >
> > Top shows it's status as R.
> >
> > Is there anything I can do to kill the thing? It's taking up all unused cpu
> > cycles (currently at 97.4%).
> 
> I assume that's kapm-idled.  That's normal, it's job is exactly burning
> unused cycles.



Um, no.

As I specified, it is an instance of a "find" command, and it just won't die.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
