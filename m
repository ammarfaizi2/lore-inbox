Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLGUcf>; Thu, 7 Dec 2000 15:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130340AbQLGUc0>; Thu, 7 Dec 2000 15:32:26 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:22012 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129345AbQLGUcM>; Thu, 7 Dec 2000 15:32:12 -0500
Date: Thu, 7 Dec 2000 20:59:39 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Daniel Chemko <dchemko@intrinsyc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multicast problems on 2.4.0?
Message-ID: <20001207205939.B21661@iapetus.localdomain>
In-Reply-To: <3A2F91F4.9000000@intrinsyc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3A2F91F4.9000000@intrinsyc.com>; from dchemko@intrinsyc.com on Thu, Dec 07, 2000 at 05:34:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 05:34:44AM -0800, Daniel Chemko wrote:
> Hello,
> I am doing development work on the 2.4.0 kernel, and can not seem to get 
> multicasting to work.
I frequently experiment with "zebra" (http://www.zebra.org) routing engine
and multicasting works for me (2.4.0-test11), according to tcpdump and
observed behavior.

If you have multiple interfaces with the same IP address (point-to-point
interfaces: same local address) then it is possible that the packets go
out via the wrong interface. This has bitten me once.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
