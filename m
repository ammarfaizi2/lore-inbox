Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288660AbSAXRnS>; Thu, 24 Jan 2002 12:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288696AbSAXRnI>; Thu, 24 Jan 2002 12:43:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18705 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288660AbSAXRnA>;
	Thu, 24 Jan 2002 12:43:00 -0500
Message-ID: <3C5047A2.1AB65595@mandrakesoft.com>
Date: Thu, 24 Jan 2002 12:42:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: RFC: booleans and the kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small issue... 

C99 introduced _Bool as a builtin type.  The gcc patch for it went into
cvs around Dec 2000.  Any objections to propagating this type and usage
of 'true' and 'false' around the kernel?

Where variables are truly boolean use of a bool type makes the
intentions of the code more clear.  And it also gives the compiler a
slightly better chance to optimize code [I suspect].

Actually I prefer 'bool' to '_Bool', if this becomes a kernel standard.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
