Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264977AbUEYRIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbUEYRIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUEYRII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:08:08 -0400
Received: from Mail.MNSU.EDU ([134.29.1.12]:58542 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S264977AbUEYRHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:07:24 -0400
Message-ID: <40B37D4A.9000304@mnsu.edu>
Date: Tue, 25 May 2004 12:07:22 -0500
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "A. op de Weegh" <aopdeweegh@rockopnh.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Granting some root permissions to certain users
References: <jbm.20040525185001.f766d1ea@TOSHIBA>
In-Reply-To: <jbm.20040525185001.f766d1ea@TOSHIBA>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A. o de Weegh,

We use a kernel patch called trustees to do just what you're talking 
about.  Unfortunately the patch hasn't really been kept up-to-date.  I 
wish something *like* this could be included in the standard kernel, but 
I guess I understand why it's not also.

Here's a link to trustees: http://trustees.sourceforge.net/

You could also use ACLs to give your teachers permissions, but that 
tends to take a lot of work imho, but it's what were looking at to 
replace trustees when I can no longer get it to patch into kernels.

Here's a link to Linux ACL: http://acl.bestbits.at/

-- 
jeffrey hundstad


A. op de Weegh wrote:

>Hi all,
>At our school, we have a installed Fedora Core 1 on a machine which acts as a 
>server. Our students may store reports and other products, that they have 
>created for their lessons, on this machine. Also the teachers have an 
>account.
> 
>I would like the teachers to have list access on ALL directories. Just as the 
>root user has. I wouldn't like the teachers to have all root permissions, but 
>they should only be able to list ALL directories available. Viewing only, no 
>writing.
> 
>Any idea how I can achieve this?
> 
>Thanx,
>Alex
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
