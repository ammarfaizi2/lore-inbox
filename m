Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262825AbRE0RTu>; Sun, 27 May 2001 13:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262827AbRE0RTj>; Sun, 27 May 2001 13:19:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48908 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262825AbRE0RTd>; Sun, 27 May 2001 13:19:33 -0400
Subject: Re: 2.4.5-ac1 hard disk corruption... acpi responsible?
To: codygould@yahoo.com.au
Date: Sun, 27 May 2001 18:17:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010527143912.23667.qmail@web12801.mail.yahoo.com> from "=?iso-8859-1?q?Cody=20Gould?=" at May 28, 2001 12:39:12 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1544AG-00026i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Today I moved to 2.4.5-ac1, the only different thing
> than normal was I enabled ACPI instead of APM.  

Bad idea. The kernel ACPI is not the most debugged, the ACPI in many BIOSes
is complete garbage and there isnt a lot you can do to debug them either.

APM is a definite better choice, at least in the shorter term

