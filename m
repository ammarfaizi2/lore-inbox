Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSKTIoV>; Wed, 20 Nov 2002 03:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbSKTIoE>; Wed, 20 Nov 2002 03:44:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35346 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265936AbSKTInm>;
	Wed, 20 Nov 2002 03:43:42 -0500
Date: Wed, 20 Nov 2002 00:44:10 -0800
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] USB core/config.c == memory corruption (resend)
Message-ID: <20021120084410.GC22936@kroah.com>
References: <Pine.LNX.4.44.0211180202090.1538-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211180202090.1538-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 02:17:37AM -0500, Zwane Mwaikambo wrote:
> Patch appended, tested with an OV511 on an Intel PIIX4

Thanks for finding this.  It happened when the structures changed a bit
a few kernels ago.  I've added this to my trees and will send it to
Linus soon.

greg k-h
