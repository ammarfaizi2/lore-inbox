Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268262AbTBNIzV>; Fri, 14 Feb 2003 03:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268256AbTBNIzV>; Fri, 14 Feb 2003 03:55:21 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:40378 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id <S268255AbTBNIzT>;
	Fri, 14 Feb 2003 03:55:19 -0500
Date: Fri, 14 Feb 2003 10:03:34 +0100
From: Roger Luethi <rl@hellgate.ch>
To: "David S. Miller" <davem@redhat.com>
Cc: ashishk@caldera.com, ak@muc.de, linux-kernel@vger.kernel.org,
       alan@redhat.com, akpm@zip.com.au, jgarzik@mandrakesoft.com,
       linux-net@vger.kernel.org, ashishk@sco.com
Subject: Re: EtherLeak generic fix - for feedback & testing.
Message-ID: <20030214090334.GA4125@k3.hellgate.ch>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	ashishk@caldera.com, ak@muc.de, linux-kernel@vger.kernel.org,
	alan@redhat.com, akpm@zip.com.au, jgarzik@mandrakesoft.com,
	linux-net@vger.kernel.org, ashishk@sco.com
References: <3.0.32.20030213175200.006cf7cc@indus.asia.caldera.com> <20030213.040918.116107261.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213.040918.116107261.davem@redhat.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003 04:09:18 -0800, David S. Miller wrote:
>    From: Ashish Kalra <ashishk@caldera.com>
>    Date: Thu, 13 Feb 2003 17:52:06 +0500
> 
>    This is a kernel-2.4.13 patch for a "generic" fix for the Etherleak security
>    issue and it works without making modifications to network device drivers. 
> 
> Not very interesting as we've fixed the problem and
> updated all the necessary drivers already.

Here's hoping nobody ever writes a driver based on pci-skeleton, which
drives a chip that has no auto-padding but comes without etherleak fix :-P.

Roger
