Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSGXNWT>; Wed, 24 Jul 2002 09:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSGXNVd>; Wed, 24 Jul 2002 09:21:33 -0400
Received: from ns.suse.de ([213.95.15.193]:57103 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317184AbSGXNU1>;
	Wed, 24 Jul 2002 09:20:27 -0400
To: "Martin Brulisauer" <martin@uceb.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
References: <20020723114703.GM11081@unthought.net.suse.lists.linux.kernel> <3D3E75E9.28151.2A7FBB2@localhost.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Jul 2002 15:23:39 +0200
In-Reply-To: "Martin Brulisauer"'s message of "24 Jul 2002 09:44:34 +0200"
Message-ID: <p73d6tdtg2s.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> As long as your pointers are 32bit this seems to be ok. But on 
> 64bit implementations pointers are not (unsigned long) so this cast 
> seems to be wrong.

A pointer fits into unsigned long on all 64bit linux ports.
The kernel very heavily relies on that.

You are probably thinking of Win64, but this is not Windows.

-Andi
