Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVCDP0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVCDP0A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVCDP0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:26:00 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:52996 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262900AbVCDPZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:25:56 -0500
Message-Id: <200503041609.j24G9OCa002888@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: se go <ass22@inbox.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: debugging TCP routines using User Mode Linux 
In-Reply-To: Your message of "Fri, 04 Mar 2005 16:09:49 +0300."
             <E1D7CYv-000Mec-00.ass22-inbox-ru@f38.mail.ru> 
References: <E1D7CYv-000Mec-00.ass22-inbox-ru@f38.mail.ru> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Mar 2005 11:09:24 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ass22@inbox.ru said:
> i need the idea how i can "freeze" all the time variables in linux tcp
>  protocol to be independent from time while debugging code... 

Disable CONFIG_UML_REAL_TIME_CLOCK, and UML time will become virtual.

				Jeff

