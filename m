Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbSJaVCw>; Thu, 31 Oct 2002 16:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSJaVCv>; Thu, 31 Oct 2002 16:02:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13322 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262805AbSJaVB4>;
	Thu, 31 Oct 2002 16:01:56 -0500
Date: Thu, 31 Oct 2002 21:08:22 +0000
From: Matthew Wilcox <willy@debian.org>
To: Juan Gomez <juang@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Proposal for new lock ownership scheme to support NFS over distributed filesystems
Message-ID: <20021031210822.N27461@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey, how about cc'ing either me or linux-fsdevel when discussing file
locking in the future as described in MAINTAINERS?

Your idea doesn't work because we need fl_owner to be the files_struct
for local locks.  It also doesn't work because IPv4 is not the only
protocol which NFS runs over.

-- 
Revolutions do not require corporate support.
