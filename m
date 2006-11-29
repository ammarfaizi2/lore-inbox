Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966997AbWK2Kib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966997AbWK2Kib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966998AbWK2Kia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:38:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10962 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966997AbWK2Ki3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:38:29 -0500
Date: Wed, 29 Nov 2006 10:38:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: S?bastien Dugu? <sebastien.dugue@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: Re: [PATCH -mm 3/5][AIO] - export good_sigevent()
Message-ID: <20061129103825.GA1773@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	S?bastien Dugu? <sebastien.dugue@bull.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Zach Brown <zach.brown@oracle.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>
References: <20061129112441.745351c9@frecb000686> <20061129113234.38c12911@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129113234.38c12911@frecb000686>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 11:32:34AM +0100, S?bastien Dugu? wrote:
> 
>                       Export good_sigevent()
> 
> 
>   Move good_sigevent() from posix-timers.c to signal.c where it belongs,
> and export it so that it can be used by other subsystems.

A little nitpick about the subject: we usually use the term 'export' when
adding an EXPORT_SYMBOL.  What would better describe your patch is

'make good_sigevent non-static'

