Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282523AbRLRN3q>; Tue, 18 Dec 2001 08:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282801AbRLRN3g>; Tue, 18 Dec 2001 08:29:36 -0500
Received: from mail.zmailer.org ([194.252.70.162]:44928 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S282523AbRLRN3W>;
	Tue, 18 Dec 2001 08:29:22 -0500
Date: Mon, 17 Dec 2001 03:29:16 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Re: dd of=blkdev seek=123 -> EINVAL ??
Message-ID: <20011217032916.C1145@mea-ext.zmailer.org>
In-Reply-To: <20011217030028.B1145@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011217030028.B1145@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Mon, Dec 17, 2001 at 03:00:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 03:00:28AM +0200, Matti Aarnio wrote:
> With recent dd (4.0p) and 2.4.17rc1 an attempt to write (with DD)
> into a block-device yields  EINVAL error.

  With   dd 4.1.3  the problem no longer exists.
  That newer version does  fstat()  on file, and notices that
  it is, indeed, a device.

  End of problem.

  But why I am seeing mysterious total hangs of this kernel is
  another story, and probably related to memory allocation...

/Matti Aarnio
