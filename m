Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbSKSTjn>; Tue, 19 Nov 2002 14:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbSKSTjn>; Tue, 19 Nov 2002 14:39:43 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59122 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267144AbSKSTjl>; Tue, 19 Nov 2002 14:39:41 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <7FA0E2B042A@vcnet.vc.cvut.cz> 
References: <7FA0E2B042A@vcnet.vc.cvut.cz> 
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, arashi@arashi.yi.org
Subject: Re: [PATCH] mii module broken under new scheme 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Nov 2002 19:46:31 +0000
Message-ID: <14517.1037735191@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


VANDROVE@vc.cvut.cz said:
>  Rusty told me that it is intentional. Add
> no_module_init;
> at the end of module. He even sent patch which fixes dozen of such
> modules (15 I had on my system...) to Linus, but it get somehow lost.

> Only question is whether we want to have it this way or no.

Some questions you might want to consider before that one:

1. How do we handle "insmod -odummy0 dummy.o ; insmod -odummy1 dummy.o"

2. When does the module name differ from the filename (modulo .o) ?

3. Given your answers to #1 and #2, is the module name redundant anyway?

--
dwmw2


