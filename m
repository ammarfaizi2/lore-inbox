Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWINKbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWINKbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWINKbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:31:13 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:3981 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751054AbWINKbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:31:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=WWFIjpkePcU+V5x/OHLv/z6Ll8xHOD4cEr1jb4dE3r98VW3w2kjEyI5S2KN6WoHQrkbhAKDAMtb7flEe9JQVR9ODbNo1BnJvT8hKyWp4/wXrNg9lods2R1vmdUk/xHJMSBtaoY3yxYw8GocNM0B3upjw1xPpJt+wVPaeA5UFl64=;
Date: Thu, 14 Sep 2006 14:30:37 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: David Stevens <dlstevens@us.ibm.com>
Cc: Jeff Layton <jlayton@poochiereds.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netdev-owner@vger.kernel.org
Subject: Re: [PATCH] make ipv4 multicast packets only get delivered to sockets	that are joined to group
Message-ID: <20060914103037.GB19959@ms2.inr.ac.ru>
References: <20060913202029.GA4666@ms2.inr.ac.ru> <OFD3BF4B0D.1F917BE2-ON882571E8.00716451-882571E8.0071B6B7@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD3BF4B0D.1F917BE2-ON882571E8.00716451-882571E8.0071B6B7@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>         No, it returns 1 (allow) if there are no filters to explicitly
> filter it. I wrote that code. :-)

I see. It did not behave this way old times.

>From your mails I understood that current behaviour matches another
implementations (BSD whatever), is it true?

Alexey
