Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286221AbSAAKCp>; Tue, 1 Jan 2002 05:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286227AbSAAKCZ>; Tue, 1 Jan 2002 05:02:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60178 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286221AbSAAKCR>; Tue, 1 Jan 2002 05:02:17 -0500
Subject: Re: Why would a valid DVD show zero files on Linux?
To: bryce@obviously.com (Bryce Nesbitt)
Date: Tue, 1 Jan 2002 10:12:24 +0000 (GMT)
Cc: cs@zip.com.au, linux-kernel@vger.kernel.org,
        Lionel.Bouton@free.fr (Lionel Bouton), Andries.Brouwer@cwi.nl
In-Reply-To: <3C314A73.E94328E9@obviously.com> from "Bryce Nesbitt" at Jan 01, 2002 12:34:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LLuC-00089s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there any cases where udf filesystems are present on cdrom's that should
> be read as iso9660?  Someone mentioned it's a hard heuristic to figure out
> which fake filename the empty iso9660 filesystem uses.  How about, instead,
> pick the larger of the two filesystems if both are present.

Now you've made the behaviour effectively random which is even worse. On
a standard DVD the two file systems are the same. Some copy protected CD's
have a UDF file system on them that isnt interesting. Some DVD's have an
ISO fs that isnt interesting.
