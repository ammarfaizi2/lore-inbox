Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132947AbRADMvI>; Thu, 4 Jan 2001 07:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132985AbRADMu6>; Thu, 4 Jan 2001 07:50:58 -0500
Received: from p3EE3CB0E.dip.t-dialin.net ([62.227.203.14]:58372 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S132947AbRADMut>; Thu, 4 Jan 2001 07:50:49 -0500
Date: Thu, 4 Jan 2001 13:50:44 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: ext3fs 0.0.5d and reiserfs 3.5.2x mutually exclusive
Message-ID: <20010104135044.A5097@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to patch ext3fs 0.0.5d on top of a 2.2.18 that already had
reiserfs 3.5.28 and failed, there are overlapping patches in fs/buffer.c
that I cannot resolve for lack of knowledge how buffer.c and journalling
are supposed to fit together.

I reported ext3fs and reiserfs incompatibilities quite some time ago.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
