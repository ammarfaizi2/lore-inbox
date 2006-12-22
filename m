Return-Path: <linux-kernel-owner+w=401wt.eu-S1752731AbWLVVHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbWLVVHP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbWLVVHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:07:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44088 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbWLVVHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:07:13 -0500
Date: Fri, 22 Dec 2006 13:07:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: parse-boot-parameter-error.patch breaks UML
Message-Id: <20061222130708.99774378.akpm@osdl.org>
In-Reply-To: <20061222205338.GA6525@ccure.user-mode-linux.org>
References: <20061222205338.GA6525@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 15:53:38 -0500
Jeff Dike <jdike@addtoit.com> wrote:

> >From the changelog:
> 
> 	Say a boot parameter is "xxx", if you give a string "xxxy", then the
> 	boot parameter's corresponding function is executed.
> 
> UML has parameters such as "ubda=<filename>" which are matched by
> __setup("ubd", ubd_setup), which hits the "error" case this patch now
> outlaws.
> 

yup, I dropped the patch for this reason, thanks.
