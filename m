Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290632AbSARIK0>; Fri, 18 Jan 2002 03:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290633AbSARIKO>; Fri, 18 Jan 2002 03:10:14 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:11477 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290632AbSARIKD>; Fri, 18 Jan 2002 03:10:03 -0500
Message-Id: <200201171854.g0HIs8vk001611@tigger.cs.uni-dortmund.de>
To: quinlan@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs updates for 2.4.17 
In-Reply-To: Message from Daniel Quinlan <quinlan@transmeta.com> 
   of "Wed, 16 Jan 2002 17:10:14 PST." <15430.9334.687743.46115@sodium.transmeta.com> 
Date: Thu, 17 Jan 2002 19:54:08 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Quinlan <quinlan@transmeta.com> said:

[...]

> fs/cramfs/README
>   - add note about sorted directory entries
>   - mkcramfs compile-time DO_HOLES option replaced by run-time -z option

I'd do it the other way around: No-holes is for backward compatibility, and
should someday go away. Let the legacy uses pay the price...
-- 
Horst von Brand			     http://counter.li.org # 22616
