Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSDAARo>; Sun, 31 Mar 2002 19:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSDAARf>; Sun, 31 Mar 2002 19:17:35 -0500
Received: from [194.46.8.33] ([194.46.8.33]:36869 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S290818AbSDAART>;
	Sun, 31 Mar 2002 19:17:19 -0500
Date: Mon, 1 Apr 2002 01:30:15 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Number of loopback devices
Message-ID: <20020401003015.GO4583@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loopbacks are so damned useful that I'm certain I'll
soon run out of them, and I doubt I'm the only person
in that position, particularly with some of the 
improvements in the crypto patches making it possible
to run an all crypto system.

I note that the number is set in loop.c

	static int max_loop = 8;

and I wonder what the safe upper limit for this is, 
and if there is some reason for not making it larger
or perhaps making it a CONFIGurable item?


