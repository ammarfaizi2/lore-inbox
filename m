Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUCEJlo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUCEJlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:41:44 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:61314 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262285AbUCEJlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:41:42 -0500
Subject: Re: [linux-usb-devel] Re: [BUG] usblp_write spins forever after
	an	error
From: David Woodhouse <dwmw2@infradead.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Greg KH <greg@kroah.com>, Andy Lutomirski <luto@myrealbox.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <4047221E.9050500@grupopie.com>
References: <402FEAD4.8020602@myrealbox.com>
	 <20040216035834.GA4089@kroah.com>  <4030DEC5.2060609@grupopie.com>
	 <1078399532.4619.129.camel@hades.cambridge.redhat.com>
	 <4047221E.9050500@grupopie.com>
Content-Type: text/plain
Message-Id: <1078479692.12176.32.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 05 Mar 2004 09:41:32 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-04 at 12:33 +0000, Paulo Marques wrote:
> Yes, unfortunately it did went into 2.6.4-rc1. However it is already corrected 
> in 2.6.4-rc2. Luckily it didn't went into any "non-rc" official release.
> 
> Please try 2.6.4-rc2, and check to see if the bug went away...

Seems to work; thanks. Does this need backporting to 2.4 too?

-- 
dwmw2


