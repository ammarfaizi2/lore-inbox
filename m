Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277316AbRJOHSf>; Mon, 15 Oct 2001 03:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277317AbRJOHSZ>; Mon, 15 Oct 2001 03:18:25 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:58499 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S277316AbRJOHSI>; Mon, 15 Oct 2001 03:18:08 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200110150631.f9F6Viu14212@www.hockin.org>
Subject: Re: your mail
To: dinesh_gandhewar@rediffmail.com
Date: Sun, 14 Oct 2001 23:31:44 -0700 (PDT)
Cc: mlist-linux-kernel@nntp-server.caltech.edu
In-Reply-To: <20011015062505.32762.qmail@mailweb33.rediffmail.com> from "Dinesh  Gandhewar" at Oct 15, 2001 06:25:05 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the effect of following statement at the end of function definition?
> *(int *)0 = 0;	

to cause a crash - you can't derefernce a pointer whose value is 0 (NULL).


