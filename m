Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSHPHo0>; Fri, 16 Aug 2002 03:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSHPHo0>; Fri, 16 Aug 2002 03:44:26 -0400
Received: from smtp.hexanet.fr ([81.23.32.141]:18698 "EHLO smtp.hexanet.fr")
	by vger.kernel.org with ESMTP id <S316786AbSHPHoZ>;
	Fri, 16 Aug 2002 03:44:25 -0400
Date: Fri, 16 Aug 2002 09:48:19 +0200
From: Jean Delvare <khali@linux-fr.org>
To: ben@beroul.uklinux.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 ATAPI cdrom I/O errors when reading CD-R
Message-Id: <20020816094819.160d5e33.khali@linux-fr.org>
Organization: linux-fr
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-portbld-freebsd4.5)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

> I'm getting errors with kernel 2.4.19 when reading a data CD-R burnt
> under Windows (using Adaptec DirectCD). Kernel 2.2.20 reads the same
> CD with no problems, as does Windows XP.

Could you please try to read the same CD-R with kernel 2.4.18? If you
still can't read the CD, try with kernel 2.4.17, and so on back to
2.2.20, so we have a chance to find the change causing the problem. (Be
careful to skip problematic kernels, 2.4.15 and 2.4.11 come to mind.)

(Note also that a dicotomic search may be more efficient. I let you
decide.)

-- 
Jean Delvare
