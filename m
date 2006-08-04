Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWHDOYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWHDOYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWHDOYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:24:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10203 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161219AbWHDOYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:24:04 -0400
Subject: Re: [RFC][PATCH] A generic boolean
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jes Sorensen <jes@sgi.com>
Cc: Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <yq0lkq4vbs3.fsf@jaguar.mkp.net>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	 <44BE9E78.3010409@garzik.org>  <yq0lkq4vbs3.fsf@jaguar.mkp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 15:42:52 +0100
Message-Id: <1154702572.23655.226.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-04 am 10:03 -0400, ysgrifennodd Jes Sorensen:
> alignments. Not to mention that on some architectures, accessing a u1
> is a lot slower than accessing an int. If a developer really wants to
> use the smaller type he/she should do so explicitly being aware of the
> impact.

Which is just fine. Nobody at the moment is using the bool type because
we don't have one. Nor is a C bool necessarily u1.

> The kernel is written in C, not C++ or Jave or some other broken
> language and C doesn't have 'bool'. 

Oh yes it does, as of C99 via stdbool.h. The only reason its not always
"bool" is compatibility considerations. Welcome to the 21st century.

Alan


