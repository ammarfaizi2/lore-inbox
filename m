Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263413AbTDCOqH>; Thu, 3 Apr 2003 09:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263414AbTDCOqH>; Thu, 3 Apr 2003 09:46:07 -0500
Received: from rth.ninka.net ([216.101.162.244]:12754 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S263413AbTDCOqG>;
	Thu, 3 Apr 2003 09:46:06 -0500
Subject: Re: [PATCH] C99 Initializers for net/ipv6 [2.4]
From: "David S. Miller" <davem@redhat.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <Pine.LNX.4.51.0304031250110.13088@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0304031250110.13088@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049381839.11405.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Apr 2003 06:57:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-03 at 02:52, Maciej Soltysiak wrote:
> Here is a conversion to C99 initializers to the files in net/ipv6.
> It compiles.
> Patch is against 2.4.21pre6.

Please DO NOT do this!  You will make merging an absolute
nightmare for me.

These kinds of across the board cleanups belong in 2.5.x and
it has already been done there.

Also, you need to be CC:'ing networking changes to me.

