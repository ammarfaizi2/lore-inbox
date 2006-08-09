Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWHIEEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWHIEEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 00:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWHIEEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 00:04:35 -0400
Received: from ozlabs.org ([203.10.76.45]:57246 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030375AbWHIEEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 00:04:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17625.24267.334013.678760@cargo.ozlabs.ibm.com>
Date: Wed, 9 Aug 2006 14:04:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com,
       haveblue@us.ibm.com, serue@us.ibm.com, clg@fr.ibm.com,
       lxc-devel@lists.sourceforge.net
Subject: Re: [PATCH] pidspace: is_init()
In-Reply-To: <20060809005637.GA13714@us.ibm.com>
References: <20060809005637.GA13714@us.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sukadev Bhattiprolu writes:

> 	There are a lot of places in the kernel where we test for init
> 	because we give it special properties.  Most  significantly init
> 	must not die.  This results in code all over the kernel test
> 	->pid == 1.
> 
> 	Introduce is_init to capture this case.  
> 
> 	With multiple pid spaces for all of the cases affected we are
> 	looking for only the first process on the system, not some other
> 	process that has pid == 1. 
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@us.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
