Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTJPWdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 18:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTJPWdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 18:33:06 -0400
Received: from panda.sul.com.br ([200.219.150.4]:15118 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S263179AbTJPWdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 18:33:04 -0400
Date: Thu, 16 Oct 2003 20:32:29 -0200
To: Jeff Garzik <jgarzik@pobox.com>, Mike Christie <mikenc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Brard Roudier <groudier@free.fr>
Subject: Re: [patch][2/3] qlogic: call request_irq() with private data
Message-ID: <20031016223229.GB378@cathedrallabs.org>
References: <20031016015349.GB1765@cathedrallabs.org> <3F8E8170.8000101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8E8170.8000101@pobox.com>
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Jeff, Mike,

> >+free_scsi_host:
> >+	kfree(hreg);
> 
> 
> should be scsi_host_put() on that last line...

i'll fix both and resend the patches.
thanks,

-- 
aris

