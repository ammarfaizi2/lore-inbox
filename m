Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbRBXNci>; Sat, 24 Feb 2001 08:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbRBXNc3>; Sat, 24 Feb 2001 08:32:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30225 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129318AbRBXNcX>; Sat, 24 Feb 2001 08:32:23 -0500
Subject: Re: [PATCH] 2.4.2 'ld' fix
To: cw@f00f.org (Chris Wedgwood)
Date: Sat, 24 Feb 2001 13:34:53 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20010225013843.A11029@metastasis.f00f.org> from "Chris Wedgwood" at Feb 25, 2001 01:38:43 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Weqd-0008KG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The ld in newer bintuils doesn't like -oformat, rather it
> requires --oformat instead. This is backwards compatible at
> least to 2.9.5 so shouldn't break anything :)
> 
> As far as I can tell on i386 uses ld in such a way.

There's a tested patch for this in -ac. The use of --oformat  seems to have
caused no problems to anyone so is worth applying

