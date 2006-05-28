Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWE1VfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWE1VfK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 17:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWE1VfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 17:35:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750956AbWE1VfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 17:35:08 -0400
Date: Sun, 28 May 2006 17:34:14 -0400
From: Dave Jones <davej@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Bisects that are neither good nor bad
Message-ID: <20060528213414.GC5741@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org
References: <20060528140238.2c25a805.dickson@permanentmail.com> <20060528140854.34ddec2a.paul@permanentmail.com> <200605282324.13431.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605282324.13431.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 11:24:12PM +0200, Rafael J. Wysocki wrote:

 > Besides, it would be helpful if you were able to get a serial console log
 > from the failing system.

I think I've seen the same problem on one of my (similar spec) laptops.
Serial console was useless. On resume, there's a short spew of garbage
(just like if the baud rate were misconfigured) over serial before it
locks up completely. Adjusting the speed on the other end of the cable 
made no difference, nothing but garbage comes out.
Maybe serial needs some suspend/resume hooks to reinitialise state ?

 > BTW, have you tried any kernel _after_ 2.6.17-rc1?  If not, I'd start from
 > these.

If it's the same problem I'm seeing, it's still there in rc5.
I'll continue to poke at it when I get time.

		Dave

-- 
http://www.codemonkey.org.uk
