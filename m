Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSIFApu>; Thu, 5 Sep 2002 20:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318209AbSIFApu>; Thu, 5 Sep 2002 20:45:50 -0400
Received: from mout0.freenet.de ([194.97.50.131]:41371 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S318207AbSIFApt>;
	Thu, 5 Sep 2002 20:45:49 -0400
Date: Fri, 6 Sep 2002 02:50:10 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm3
Message-ID: <20020906005010.GB8109@prester.freenet.de>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D77143F.E441133D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D77143F.E441133D@zip.com.au>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

On Thu, 05 Sep 2002, Andrew Morton wrote:

> URL: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.33/2.5.33-mm3/
> 
> +filemap-integration.patch
> 
>   Cleanup and code consolidation for readv and writev: generic_file_read()
>   and generic_file_write() take an iovec, and tons of code goes away.
> 
>   A work in progress.

Just compiled 2.5.33 with mm3 patch:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.33; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.33/kernel/fs/ext2/ext2.o
depmod:         generic_file_writev

Best regards,
Axel Siebenwirth
