Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269785AbTGKFIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 01:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269786AbTGKFIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 01:08:12 -0400
Received: from netcore.fi ([193.94.160.1]:40712 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S269785AbTGKFID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 01:08:03 -0400
Date: Fri, 11 Jul 2003 08:22:39 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Mika Liljeberg <mika.liljeberg@welho.com>
cc: Andre Tomt <andre@tomt.net>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
In-Reply-To: <1057900800.3588.50.camel@hades>
Message-ID: <Pine.LNX.4.44.0307110821110.24981-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jul 2003, Mika Liljeberg wrote:
> On Fri, 2003-07-11 at 07:51, Pekka Savola wrote:
> > Well, the system may make some sense, but IMHO, there is still zero sense 
> > in policing this thing when you add a route.  That's just plain bogus.  
> > This is a bug which must be fixed ASAP.
> 
> Correct me if I'm wrong but I think in this case the interface had
> forwarding enabled and the sanity check in fact prevented a default
> route pointing to the node itself from being configured.
>
> Otherwise I fully agree. The subnet router anycast address doesn't
> warrant any special handling.

If that's the case, it's OK -- it's OK, I don't remember the details.

(It might be nice to have configurable /proc option on whether to enable 
the subnet router anycast address at all, but that's also a different 
story..)

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings

