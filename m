Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbTAVLMP>; Wed, 22 Jan 2003 06:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTAVLMP>; Wed, 22 Jan 2003 06:12:15 -0500
Received: from [213.86.99.237] ([213.86.99.237]:9186 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267430AbTAVLMO>; Wed, 22 Jan 2003 06:12:14 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030121214651.GA958@mars.ravnborg.org> 
References: <20030121214651.GA958@mars.ravnborg.org>  <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il> <E18a1aZ-0006mL-00@bigred.inka.de> <1042930522.15782.12.camel@laptop.fenrus.com> <E18ai8O-00032u-00@bigred.inka.de> <1043098758.27074.2.camel@laptop.fenrus.com> <E18b5kc-0003BB-00@bigred.inka.de> 
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Olaf Titz <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Jan 2003 11:21:14 +0000
Message-ID: <10769.1043234474@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sam@ravnborg.org said:
> From your previous posts I have only noted down one feature that is
> not yet planned:  1) Building modules separate from module src.

This would be cute. When testing a single module under both 2.4 and 2.5 
kernels, I often have to 'make clean ; make LINUXDIR=/usr/src/linux-2.5'
and 'make clean; make' to switch between them. Having separate object trees 
would make life a lot nicer.

--
dwmw2


