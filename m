Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRBYNuj>; Sun, 25 Feb 2001 08:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbRBYNu3>; Sun, 25 Feb 2001 08:50:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54278 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129136AbRBYNuR>; Sun, 25 Feb 2001 08:50:17 -0500
Subject: Re: reiserfs: still problems with tail conversion
To: W1012@lina.inka.de (Bernd Eckenfels)
Date: Sun, 25 Feb 2001 13:53:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14WsgH-00006l-00@sites.inka.de> from "Bernd Eckenfels" at Feb 25, 2001 05:21:09 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14X1c9-000335-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have seen null byte corruptions in syslog files with ext2 in various
> kernels. So perhaps it is a general VFS problem?

Im very dubious. The post fsck nulls in syslog case is a well understood one
with the box crashing as it extends the file and never gets to commit the data
bytes.

Different thing I suspect.

