Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271072AbRHTEgg>; Mon, 20 Aug 2001 00:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271073AbRHTEg1>; Mon, 20 Aug 2001 00:36:27 -0400
Received: from [65.10.228.207] ([65.10.228.207]:19698 "HELO whatever.local")
	by vger.kernel.org with SMTP id <S271072AbRHTEgM>;
	Mon, 20 Aug 2001 00:36:12 -0400
From: chuckw@ieee.org
Date: Sun, 19 Aug 2001 12:44:42 -0400
To: linux-kernel@vger.kernel.org
Subject: Question on coding style in networking code
Message-ID: <20010819124442.G2388@ieee.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	First off, this is probably a straight C question, but here goes...

	I was looking at the kernel code, and in protocol.c the protocol structures are
instansiated and filled.  Now, I have seen/used the following syntax:
	struct x y = { x, y, z };
	
I have not seen the following:
	struct x y = {
		member1: x,
		member2: y,
		member3: z
	};

What is the deal with this?  Does the second way have any advantage over the previous?

Thanks in advance,
Chuck
		
