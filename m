Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTBBIjD>; Sun, 2 Feb 2003 03:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTBBIjD>; Sun, 2 Feb 2003 03:39:03 -0500
Received: from host25-120.pool80181.interbusiness.it ([80.181.120.25]:9088
	"EHLO igor.opun.it") by vger.kernel.org with ESMTP
	id <S265168AbTBBIjC>; Sun, 2 Feb 2003 03:39:02 -0500
Message-ID: <3E3CDB58.A697BFEF@libero.it>
Date: Sun, 02 Feb 2003 09:48:24 +0100
From: Abramo Bagnara <abramo.bagnara@libero.it>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en, it
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: futimes()?
References: <b1htmi$9r6$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> In the general vein of avoiding security holes by using file
> descriptors when doing repeated operations on the same filesystem
> object, I have noticed that there doesn't seem to be a way to set
> mtime using a file descriptor.  Do we need a futimes() syscall?

Parallel to that, there is the long time needed lutimes() syscall.

Who has never been annoyed that restoring a backup there's no way to
restore former symlink mtime?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy
