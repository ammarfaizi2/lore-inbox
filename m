Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVB1XfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVB1XfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVB1Xe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:34:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44672 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261817AbVB1Xev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:34:51 -0500
Date: Mon, 28 Feb 2005 23:34:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@infradead.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mark_Salyzyn@adaptec.com
Subject: Re: [2.6 patch] SCSI: possible cleanups
Message-ID: <20050228233447.GA20340@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark_Salyzyn@adaptec.com
References: <20050228213159.GO4021@stusta.de> <20050228222509.GB19376@infradead.org> <20050228230155.GV4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228230155.GV4021@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 12:01:55AM +0100, Adrian Bunk wrote:
> On Mon, Feb 28, 2005 at 10:25:09PM +0000, Christoph Hellwig wrote:
> >...
> > >   - constants.c: scsi_print_hostbyte
> > >   - constants.c: scsi_print_driverbyte
> > 
> > these we'll probably keep for now.
> >...
> 
> keep = #if 0 ?

In this case yes, for the others case I want to keep them beeing built.
