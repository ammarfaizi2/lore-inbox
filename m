Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbTBFVBr>; Thu, 6 Feb 2003 16:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbTBFVBr>; Thu, 6 Feb 2003 16:01:47 -0500
Received: from hera.cwi.nl ([192.16.191.8]:61622 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267389AbTBFVBq>;
	Thu, 6 Feb 2003 16:01:46 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 6 Feb 2003 22:11:23 +0100 (MET)
Message-Id: <UTC200302062111.h16LBN024349.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: syscall documentation (3)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Shouldn't kill and tkill be in one manpage that documents both?

Perhaps, but I think having them separate is better:
- killpg is also separate
- separate pages are easy: one can write "conforming to POSIX"
  in one, and "Linux specific" in the other. Merging gives a
  messy page
- the audiences will differ, I think

But I put a "SEE ALSO" in kill.2 referring to tkill.2.

Andries

