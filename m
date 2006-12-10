Return-Path: <linux-kernel-owner+w=401wt.eu-S1762427AbWLJTeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762427AbWLJTeV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762430AbWLJTeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:34:20 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:56861
	"EHLO home.chandlerfamily.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762427AbWLJTeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:34:20 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE support on Intel DG965SS
Date: Sun, 10 Dec 2006 19:34:17 +0000
User-Agent: KMail/1.9.5
Cc: Avi Kivity <avi@argo.co.il>
References: <200612101558.34005.alan@chandlerfamily.org.uk> <457C3635.5030509@argo.co.il>
In-Reply-To: <457C3635.5030509@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612101934.17964.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 December 2006 16:30, Avi Kivity wrote:
> Alan Chandler wrote:
> > I have been trying to find out if the kernel supports the IDE
> > channel (with a DVD/CD-R unit attached) on my Intel DG965SS
>
> I have the same board at home.  I use all-generic-ide (without
> pci=...)
>
> Do you have CONFIG_IDE_GENERIC set?

It was a module, so presumably that was stopping the parameter working 
(or maybe should have loaded it in my initrd).   Anyway, recompiled 
with it as built in, and with the kernel parameter it seems to work 
now.  Thanks.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
