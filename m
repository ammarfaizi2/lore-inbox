Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSKTUxT>; Wed, 20 Nov 2002 15:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSKTUxT>; Wed, 20 Nov 2002 15:53:19 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:28918 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262469AbSKTUxS>; Wed, 20 Nov 2002 15:53:18 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3DDBD70B.7090501@us.ibm.com> 
References: <3DDBD70B.7090501@us.ibm.com> 
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] early command-line parsing 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Nov 2002 21:00:22 +0000
Message-ID: <24571.1037826022@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not all architectures have asm/setup.h. And not all have the command line 
somewhere convenient before setup_arch runs, although that could perhaps be 
changed.

I wonder if calling checksetup(0, ...) should be called from setup_arch as 
soon as the command line is available, rather than in start_kernel().

--
dwmw2


