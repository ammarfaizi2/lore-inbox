Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292663AbSCDScf>; Mon, 4 Mar 2002 13:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292657AbSCDSc0>; Mon, 4 Mar 2002 13:32:26 -0500
Received: from mnh-1-26.mv.com ([207.22.10.58]:2822 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S292664AbSCDScN>;
	Mon, 4 Mar 2002 13:32:13 -0500
Message-Id: <200203041834.NAA03295@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "04 Mar 2002 09:46:55 PST."
             <a60buf$lfi$1@cesium.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 13:34:24 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com said:
> I think it's you -- you seem to suffer from the "my application is the
> only one that counts" syndrome.  If you want to pages dirtied, then
> dirty them using memset() or similar. 

I think you and Alan think I want the host kernel to do the dirtying.  Not so,
I want no changes on the host.  I want a hook that UML can use to make sure
that all pages that it allocates are backed.

And memset or something similar is exactly what I have in mind.

				Jeff

