Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292840AbSCDUeZ>; Mon, 4 Mar 2002 15:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292843AbSCDUeP>; Mon, 4 Mar 2002 15:34:15 -0500
Received: from mnh-1-15.mv.com ([207.22.10.47]:519 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S292840AbSCDUeF>;
	Mon, 4 Mar 2002 15:34:05 -0500
Message-Id: <200203042036.PAA04031@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Mon, 04 Mar 2002 10:33:41 PST."
             <3C83BE05.6060600@zytor.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 15:36:15 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com said:
> So why, then, phrase this as a feature request??? 

Because it requires a hook in the generic kernel allocator that UML can
use to make sure that all allocated pages are backed on the host.

				Jeff

