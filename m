Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTJZIvZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 03:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTJZIvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 03:51:25 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:31901 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262942AbTJZIvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 03:51:21 -0500
Message-ID: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results end
Date: Sun, 26 Oct 2003 17:49:29 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The drive finally reallocated the block and there are no longer any visible
bad blocks.

I will not be able to perform the following planned test:
  Well, in a future weekend, I will try to see if ext2fs really takes action
  on permanently bad blocks that are detected during normal operations on a
  mounted partition.

But I think the underlying defects remain in need of correction.  Toshiba
knows about theirs but will probably never say if they make any fixes.  Mr.
Reiser and friends have plans to add important features, and I am unable to
detect if ext2fs needs it.  (As mentioned before, I understand that ext2fs
can do it during formatting and fsck, but no one seems to be saying what
happens if a permanently bad block is detected during normal operation on a
mounted partition.)

