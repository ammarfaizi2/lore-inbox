Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268055AbRGZPeP>; Thu, 26 Jul 2001 11:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268063AbRGZPeF>; Thu, 26 Jul 2001 11:34:05 -0400
Received: from pop3.telenet-ops.be ([195.130.132.40]:53467 "EHLO
	pop3.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S268055AbRGZPd6>; Thu, 26 Jul 2001 11:33:58 -0400
Date: Thu, 26 Jul 2001 17:34:00 +0200
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: linux-kernel@vger.kernel.org
Subject: Re: Weird ext2fs immortal directory bug
Message-ID: <20010726173400.A469@Zenith.starcenter>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010726105812.16941A-100000@chaos.analogic.com> <Pine.LNX.4.30.0107261104220.18300-100000@spring.webconquest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0107261104220.18300-100000@spring.webconquest.com>; from sentry21@cdslash.net on Thu, Jul 26, 2001 at 11:04:48AM -0400
X-Operating-System: Linux 2.4.7-ac1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 11:04:48AM -0400, sentry21@cdslash.net wrote:
> sentry21@Petra:1:/$ sudo rm -rf lost+found/
> rm: cannot unlink `lost+found/#3147': Operation not permitted
> rm: cannot remove directory `lost+found': Directory not empty

Have you tried "chattr -i \#3147" and then "rm -rf \#3147"? 

-- 
 Sven Vermeulen            -    Key-ID CDBA2FDB 
 LUG: http://www.lugwv.be  -    http://www.keyserver.net

