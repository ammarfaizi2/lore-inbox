Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbTAFN7r>; Mon, 6 Jan 2003 08:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbTAFN7r>; Mon, 6 Jan 2003 08:59:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45956
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266736AbTAFN7p>; Mon, 6 Jan 2003 08:59:45 -0500
Subject: Re: [2.5 patch] re-add zft_dirty to zftape-ctl.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       claus@momo.math.rwth-aachen.de, linux-tape@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030106133101.GS6114@fs.tum.de>
References: <20030104151404.GX6114@fs.tum.de>
	 <1041712127.2036.1.camel@irongate.swansea.linux.org.uk>
	 <20030106133101.GS6114@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041864640.17472.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 14:50:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 13:31, Adrian Bunk wrote:
> Is the patch below correct?

I think so yes. The module is locked until close by refcount and the close seems to flush the
tape headers

