Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVHMOdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVHMOdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVHMOdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 10:33:39 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:6853 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751331AbVHMOdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 10:33:38 -0400
Date: Sat, 13 Aug 2005 09:33:35 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BSD jail
Message-ID: <20050813143335.GA5044@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <bda6d13a050812174768154ea5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a050812174768154ea5@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joshua Hudson (joshudson@gmail.com):
> I had been wanting this functionality myself, but for some reason it never found
> its way into the stock kernel.  I looked around, started coding,
> looked some more,
> coded some more, looked some more until I found this:
> 
> http://kerneltrap.org/node/3823
> 
> I suppose the reason it wasn't applied is lack of good IPv6 support.

The latest version (which is still quite old) is at
http://www.sf.net/projects/linuxjail and does have ipv6 support.  The last
time I submitted it, Christoph had objected to the way the networking was
done in general.  I've tried twice to float a generalized "per-process
network namespaces" patch, but haven't really found a good approach.

I suspect that the best approach would be to take the linux-vserver
ngnet implementation and convert it to a standalone network namespace
plus virtual network device implementation.  Do you care to give this
a try?

thanks,
-serge

