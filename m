Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263352AbSJFHxG>; Sun, 6 Oct 2002 03:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263353AbSJFHxG>; Sun, 6 Oct 2002 03:53:06 -0400
Received: from gate.in-addr.de ([212.8.193.158]:44818 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S263352AbSJFHxF>;
	Sun, 6 Oct 2002 03:53:05 -0400
Date: Sun, 6 Oct 2002 09:58:29 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Austin Gonyou <austin@coremetrics.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
Message-ID: <20021006075829.GB23504@marowsky-bree.de>
References: <41EBA11203419D4CA8EB4C6140D8B4017CD8EE@AVEXCH01.qlogic.org> <1033862965.27451.51.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1033862965.27451.51.camel@UberGeek.coremetrics.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-05T19:09:26,
   Austin Gonyou <austin@coremetrics.com> said:

> Is there a way to resolve this, either at the driver level, IMHO the
> place it *should* happen. At the storage level, the place that it could
> also happen, or in the Kernel?

You can always use md multipathing; an extension to the 2.4 multipathing has
been implemented by Jens Axboe and yours truely and is available at
http://lars.marowsky-bree.de/dl/md-mp; we'll see how Neil takes it when he
returns from vacation ;-)

We'll also be shipping that patch as part of United Linux.

IBM also did an extension to the LVM1 code to support multipathing; I don't
have an URL handy right now, but Google will certainly help out.

For 2.5, this is still not fully hashed out, but I assume you are running 2.4
on a production system ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel
Research and Development, SuSE Linux AG
 
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister

