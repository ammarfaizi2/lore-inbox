Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVFGQCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVFGQCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVFGQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:02:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23008 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261920AbVFGQC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:02:28 -0400
Message-ID: <42A5C3D2.9010209@redhat.com>
Date: Tue, 07 Jun 2005 11:57:06 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
CC: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: Zeroed pages returned for heap
References: <Pine.LNX.4.44.0506070936530.4569-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0506070936530.4569-100000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagendra Singh Tomar wrote:

>Hi all,
>	The short version first.
>Is it OK for an application (a C library implementing malloc/calloc is 
>also an application) to assume that the pages returned by the OS for heap 
>allocation (either directly thru brk() or thru mmap(MAP_ANONYMOUS)) will 
>be zero filled. 
>

An application which makes assumptions about the contents of newly allocated
memory would seem to be making very dangerous assumptions.

Ignoring that, would it not be considered to be a security violation to hand
pieces of memory to applications without erasing the old contents of the 
pages?

    Thanx...

       ps
