Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSGIRnW>; Tue, 9 Jul 2002 13:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSGIRnV>; Tue, 9 Jul 2002 13:43:21 -0400
Received: from mnh-1-15.mv.com ([207.22.10.47]:64516 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317352AbSGIRnU>;
	Tue, 9 Jul 2002 13:43:20 -0400
Message-Id: <200207091847.NAA03034@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Re: user-mode port 0.58-2.4.18-36 
In-Reply-To: Your message of "Tue, 09 Jul 2002 19:05:54 +0200."
             <20020709170554.GC31838@atrey.karlin.mff.cuni.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 13:47:29 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@suse.cz said:
> I don't understand here. So UML never ever permits access to /dev/kmem?

Jeez, have a look at the code.  CAP_SYS_RAWIO (and write access to /dev/kmem)
is disabled only when 'jail' is turned on.

				Jeff

