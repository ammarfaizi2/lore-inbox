Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUIMG7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUIMG7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 02:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUIMG7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 02:59:30 -0400
Received: from g.r.o.s.s.stupendous.org ([80.126.179.10]:57605 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S266216AbUIMG73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 02:59:29 -0400
Date: Mon, 13 Sep 2004 08:59:27 +0200
From: Jurjen Oskam <jurjen@stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)Denial of Service Attack
Message-ID: <20040913065927.GA6100@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <02b201c498f6$8bb92540$0300a8c0@s> <002501c498f8$0a4ebc20$0200a8c0@wolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002501c498f8$0a4ebc20$0200a8c0@wolf>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 12:40:56PM -0600, Wolfpaw - Dale Corse wrote:

> the bug is application level in this case. Can you explain
> though, how it is appropriate to have no timeout on CLOSE_WAIT.

See TCP/IP Illustrated, Volume 1 by W. Richard Stevens (ISBN
0-201-63346-9), page 238: "TCP Half-Close".

In short, you don't have a timeout on CLOSE_WAIT for the same reason you
don't have a timeout on ESTABLISHED.

-- 
Jurjen Oskam
"I often reflect that if "privileges" had been called "responsibilities" or
"duties", I would have saved thousands of hours explaining to people why
they were only gonna get them over my dead body." - Lee K. Gleason, VMS sysadmin
