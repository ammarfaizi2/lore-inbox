Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265501AbUFCE2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUFCE2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 00:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUFCE2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 00:28:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:54425 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265499AbUFCE2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 00:28:42 -0400
Date: Wed, 2 Jun 2004 21:28:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-Id: <20040602212803.0ae212ba.akpm@osdl.org>
In-Reply-To: <40BDD8AC.8080706@blueyonder.co.uk>
References: <40BDD8AC.8080706@blueyonder.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>
> As with 2.6.7-rc1-mm1, I'm seeing the same problem on 2.6.7-rc2-mm1. 
>  2.6.7-rc1 and 2.6.7-rc2 are OK. It hangs needing a hard reset setting up 
>  /dev/pts, with console=ttyS1 .... same as before. SuSE 9.1 on A7N8X-E 
>  nforce2 chipset.

Works OK here.  Is it the `console=ttyS1' which is causing the hang?  If
not, what?  Try removing boot options, stripping config options, etc.


