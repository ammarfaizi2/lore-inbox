Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285163AbRLMUWX>; Thu, 13 Dec 2001 15:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285160AbRLMUWF>; Thu, 13 Dec 2001 15:22:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22404 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285161AbRLMUVp>;
	Thu, 13 Dec 2001 15:21:45 -0500
Date: Thu, 13 Dec 2001 12:21:26 -0800 (PST)
Message-Id: <20011213.122126.125897109.davem@redhat.com>
To: marcelo@conectiva.com.br
Cc: ledzep37@attbi.com, linux-kernel@vger.kernel.org
Subject: Re: __devexit_p() in linux-2.5.1-preX?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0112131413480.28370-100000@freak.distro.conectiva>
In-Reply-To: <20011212.192636.133010681.davem@redhat.com>
	<Pine.LNX.4.21.0112131413480.28370-100000@freak.distro.conectiva>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marcelo Tosatti <marcelo@conectiva.com.br>
   Date: Thu, 13 Dec 2001 14:14:18 -0200 (BRST)
   
   I've already asked Linus about that and he told me that he is giving
   higher priority to core changes now and wants to do the merges later... 

That is going to be a lot to accumulate whenever the code change
priority goes back down, really.

To me it makes more sense to do a release or two making one of the
core changes, and fixing it up, then do a sync pass to get the bug
fixes piling up in 2.4.x

I think Linus's scheme is going to result in either a lot of missed
fixes or a lot of unnecessary work and headaches for some poor
person. :-)
