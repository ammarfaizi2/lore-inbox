Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282510AbRLDIpz>; Tue, 4 Dec 2001 03:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280251AbRLDIpo>; Tue, 4 Dec 2001 03:45:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29201 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279814AbRLDIpl>; Tue, 4 Dec 2001 03:45:41 -0500
Message-ID: <3C0C8D2D.8060006@transmeta.com>
Date: Tue, 04 Dec 2001 00:45:33 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, David Weinehall <tao@acc.umu.se>,
        Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Prepatches and kernel.org incdiff robot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have hard-linked the prepatches I have been able to find into 
/pub/linux/kernel/v*.*/testing/old/, following the "modern" naming 
scheme, so the incdiff robot could produce incrementals against them.

First, I wanted to let you know what the deal was... they are just 
hardlinks against what is elsewhere (/pub/linux/testing or 
/pub/linux/people), with different names.

Second, there were several prepatches that did not apply cleanly, which 
broke the robot, and which I had to remove from the testing/old 
directories (I did not touch the original link, of course.)  The only 
one that was anywhere close to recent and might be worth fixing was 
2.0.40-pre2; the other ones were 2.2.18 versions (-pre1,2,3,4, and 26.)

I mostly wanted to give you everyone a heads-up.

	-hpa

