Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTDGOde (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTDGOde (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:33:34 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:35569 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263452AbTDGOdd (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:33:33 -0400
Message-ID: <3E918ED6.1090706@nortelnetworks.com>
Date: Mon, 07 Apr 2003 10:44:38 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Keith Owens <kaos@ocs.com.au>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: correct to set -nostdinc and then include <stdarg.h> ?
References: <3E910172.8030406@nortelnetworks.com>	 <23076.1049692512@kao2.melbourne.sgi.com>	 <20030407074722.A9367@flint.arm.linux.org.uk>	 <3E91866C.2000902@nortelnetworks.com> <1049724971.4773.2493.camel@workshop.saharact.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:

> You might just have to give --bindir, etc to the exact locations.
> Also, make sure you do not have symlinks, etc in /usr/bin, as they
> sometimes 'confuses' gcc ...

Hmm...maybe that's it.  I've got /usr/local/bin/gcc322 symlinked to 
/usr/local/gcc322/bin/gcc.  The equivalent link works with gcc 2.95.3 though...

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

