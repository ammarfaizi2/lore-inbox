Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTENGJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTENGJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:09:07 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:20399 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262072AbTENGI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:08:59 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Christopher Hoover <ch@murgatroid.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
References: <20030513213157.A1063@heavens.murgatroid.com>
	<20030514071446.A2647@infradead.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 14 May 2003 15:20:54 +0900
In-Reply-To: <20030514071446.A2647@infradead.org>
Message-ID: <buofzniujzt.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> > Not everyone needs futex support, so it should be optional.  This is
> > needed for small platforms.
> 
> Looks good.  I think you want to disable it unconditionally for !CONFIG_MMU.

Are futexes unusable without an MMU (I don't know anything about the
implementation)?

Thanks,

-Miles
-- 
"I distrust a research person who is always obviously busy on a task."
   --Robert Frosch, VP, GM Research
