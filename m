Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSFRGlF>; Tue, 18 Jun 2002 02:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSFRGlE>; Tue, 18 Jun 2002 02:41:04 -0400
Received: from [148.246.68.170] ([148.246.68.170]:2564 "EHLO zion.sytes.net")
	by vger.kernel.org with ESMTP id <S317341AbSFRGlD>;
	Tue, 18 Jun 2002 02:41:03 -0400
Date: Tue, 18 Jun 2002 01:40:56 -0500
From: Felipe Contreras <al593181@mail.mty.itesm.mx>
To: linux-kernel@vger.kernel.org
Subject: Weird make bug in 2.5.22
Message-ID: <20020618064056.GA2456@zion.mty.itesm.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have this problem when running 2.5.22, make can't run itself inside a
Makefile.

Let's say I have this Makefile:
test:
	( make -v )

It fails saying this:
( make -v )
make: *** [test] Error 139

I don't have any idea about what can be causing this error, might be something
to do with reiserfs...

Any ideas?

-- 
Felipe Contreras
