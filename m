Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUECLr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUECLr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 07:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUECLr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 07:47:26 -0400
Received: from se2.ruf.uni-freiburg.de ([132.230.2.222]:21222 "EHLO
	se2.ruf.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S262328AbUECLrY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 07:47:24 -0400
X-Scanned: Mon, 3 May 2004 13:46:58 +0200 Nokia Message Protector V1.3.21 2004031416 - RELEASE
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modused: mark some modules as in use (Re: [PATCH] (fix:oops with rmmod i8042))
References: <Pine.GSO.4.58.0405030953100.11293@stekt37>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 03 May 2004 13:46:57 +0200
In-Reply-To: <Pine.GSO.4.58.0405030953100.11293@stekt37>
Message-ID: <xb7ad0pu40e.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tuukka" == Tuukka Toivonen <tuukkat@ee.oulu.fi> writes:

    Tuukka> Compiling i8042 as module, then loading it with atkbd and
    Tuukka> serio, and then unloading i8042 causes a kernel Oops
    Tuukka> (shown below).

I have  developed an independent  tool that can  be used to  (sort of)
work  around  this  problem.  The  tool  can  be  used to  prevent  an
accidental 'rmmod i8042'.  Here it is:

        http://www.informatik.uni-freiburg.de/~danlee/fun/modused/



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

