Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWFVDf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWFVDf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWFVDf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:35:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751559AbWFVDf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:35:56 -0400
Date: Wed, 21 Jun 2006 20:35:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: kaigai@ak.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: Add pacct_struct to fix some pacct bugs.
Message-Id: <20060621203550.b14e867a.akpm@osdl.org>
In-Reply-To: <449A0967.2020701@ak.jp.nec.com>
References: <449794BB.8010108@ak.jp.nec.com>
	<20060619234212.b95e5734.akpm@osdl.org>
	<4497A34C.2000104@ak.jp.nec.com>
	<449A0967.2020701@ak.jp.nec.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 12:07:19 +0900
KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:

> The seriese of patches fixes some process accounting bugs.

OK, thanks for splitting those up.  A few patch-protocol things:

- Please make the email Subject: reflect the patch contents - all three
  patches here were called "Re: Add pacct_struct to fix some pacct bugs."

- Please don't indent the changlogs by five spaces.  Start in column zero.

- Your email client performs space-stuffing, which corrupts the patches. 
  I fixed them all by hand.

  I don't know if it's possible to prevent thunderbird from doing this
  (my mozilla bugzilla record on this has to be three years old, and is
  still open).  You might have to use text/plain attachments in the future.
