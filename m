Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSBMO4z>; Wed, 13 Feb 2002 09:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbSBMO4p>; Wed, 13 Feb 2002 09:56:45 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:28918 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285338AbSBMO4i>; Wed, 13 Feb 2002 09:56:38 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3C6A2F86.E5C322D4@zip.com.au> 
In-Reply-To: <3C6A2F86.E5C322D4@zip.com.au> 
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] compile fixes 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Feb 2002 14:56:32 +0000
Message-ID: <22568.1013612192@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


akpm@zip.com.au said:
> -static void __exit cleanup_elan_104nc(void) 
> +static void cleanup_elan_104nc(void)
>  {

Bah. Now it doesn't get dropped from the kernel after init is done either.
Anyone for an __initexit section? 

(I'll apply it to my tree as soon as my CVS server comes back online though 
- it's obviously the right thing to do in the meantime)

--
dwmw2


