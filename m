Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264747AbTFEQmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbTFEQmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:42:11 -0400
Received: from sccrmhc11.attbi.com ([204.127.202.55]:11989 "EHLO
	sccrmhc11.attbi.com") by vger.kernel.org with ESMTP id S264747AbTFEQmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:42:09 -0400
Message-ID: <3EDF76D0.3080006@kegel.com>
Date: Thu, 05 Jun 2003 09:58:56 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: m.bagni@marcobagn.com
CC: linux-kernel@vger.kernel.org
Subject: re: gcc 3.3-2 complains with arch/i386/meth-emu/poly.h
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,
thanks for your post - yes, we definitely need to be able to
compile with gcc-3.3.  Since it looks like you're a newcomer,
here are a few tips:

When you post changes like this,
please mention which version of the kernel source you're starting from.

Also, the preferred format for posting
changes like this is as an inline patch; see
http://www.tux.org/lkml/#s1-10
http://www.tux.org/lkml/#s4-1
http://www.kegel.com/academy/opensource.html#patches

Finally, check a recent version of the kernel before posting a patch.
It looks like this issue has been fixed in 2.5; see
http://lxr.linux.no/source/arch/i386/math-emu/poly.h?v=2.5.56
You might want to check 2.4.21-pre6 to see if it's been
fixed there yet, and if not, submit a patch to Marcello,
preferably using the same approach used in the 2.5 fix.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

