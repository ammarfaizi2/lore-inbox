Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUENRsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUENRsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUENRsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:48:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:19647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261947AbUENRsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:48:31 -0400
Date: Fri, 14 May 2004 10:48:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       luto@myrealbox.com, chrisw@osdl.org,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] capabilites, take 2
Message-ID: <20040514104827.R21045@build.pdx.osdl.net>
References: <1084536213.951.615.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1084536213.951.615.camel@cube>; from albert@users.sourceforge.net on Fri, May 14, 2004 at 08:03:33AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Albert Cahalan (albert@users.sourceforge.net) wrote:
> This would be an excellent time to reconsider how capabilities
> are assigned to bits. You're breaking things anyway; you might
> as well do all the breaking at once. I want local-use bits so
> that the print queue management access isn't by magic UID/GID.
> We haven't escaped UID-as-priv if server apps and setuid apps
> are still making UID-based access control decisions.

This is too volatile in stable series.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
