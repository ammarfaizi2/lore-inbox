Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288153AbSAMVFh>; Sun, 13 Jan 2002 16:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288156AbSAMVF1>; Sun, 13 Jan 2002 16:05:27 -0500
Received: from [24.93.67.54] ([24.93.67.54]:34579 "EHLO mail7.carolina.rr.com")
	by vger.kernel.org with ESMTP id <S288153AbSAMVFL>;
	Sun, 13 Jan 2002 16:05:11 -0500
From: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Date: Sun, 13 Jan 2002 16:04:47 -0500
To: linux-kernel@vger.kernel.org
Subject: patch-2.5.1-dj14.diff.gz is broken
Message-ID: <20020113210447.GA8215@clt88-175-140.carolina.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ gunzip -dc ../patch-2.5.1-dj14.diff.gz | patch -p1 
patching file include/pcmcia/cs.h
patching file include/scsi/scsicam.h
patching file include/scsi/sg.h
patch unexpectedly ends in middle of line
patch: **** unexpected end of file in patch

if I do 
gunzip -t ../patch-2.5.1-dj14.diff.gz 
gunzip: patch-2.5.1-dj14.diff.gz: unexpected end of file

-- 
Zilvinas Valinskas
