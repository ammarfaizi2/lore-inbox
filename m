Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264633AbSJPBuS>; Tue, 15 Oct 2002 21:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264719AbSJPBuS>; Tue, 15 Oct 2002 21:50:18 -0400
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:30130 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S264633AbSJPBuR>; Tue, 15 Oct 2002 21:50:17 -0400
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200210160156.DAA25005@faui11.informatik.uni-erlangen.de>
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
To: levon@movementarian.org
Date: Wed, 16 Oct 2002 03:56:10 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

+               return (u32)dentry;

Um, isn't this supposed to uniquely identify the dentry?
On a platform with 64-bit pointers there's now the theoretical
possibility of different dentries getting the same cookie ...

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
