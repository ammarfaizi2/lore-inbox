Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUEFViZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUEFViZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUEFViZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:38:25 -0400
Received: from emess.mscd.edu ([147.153.170.17]:5324 "EHLO emess.mscd.edu")
	by vger.kernel.org with ESMTP id S263085AbUEFViY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:38:24 -0400
From: Steve Beaty <beaty@emess.mscd.edu>
Message-Id: <200405062137.i46LbnjF017523@emess.mscd.edu>
Subject: Re: sigaction, fork, malloc, and futex
To: zlynx@acm.org (Zan Lynx)
Date: Thu, 6 May 2004 15:37:49 -0600 (MDT)
Cc: chris@scary.beasts.org,
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1083711395.29189.10.camel@localhost.localdomain> from "Zan Lynx" at May 04, 2004 04:56:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not sure it is really a problem though.  I don't think you should
> be allowed to fork inside a signal handler.  That seems very wrong.

	i can't disagree :-)  but fork() is supposed to be reentrant...

-- 
Dr. Steve Beaty (B80)                                 Associate Professor
Metro State College of Denver                        beaty@emess.mscd.edu
VOX: (303) 556-5321                                 Science Building 134C
FAX: (303) 556-5381                         http://clem.mscd.edu/~beatys/
