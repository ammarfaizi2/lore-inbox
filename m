Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWH1Jcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWH1Jcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWH1Jcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:32:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56251 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932464AbWH1Jcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:32:32 -0400
Date: Mon, 28 Aug 2006 10:32:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
Message-ID: <20060828093202.GC8980@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Richard Knutsson <ricknu-0@student.ltu.se>,
	James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <44EFBEFA.2010707@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EFBEFA.2010707@student.ltu.se>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 05:24:42AM +0200, Richard Knutsson wrote:
> Hello
> 
> Just would like to ask if you want patches for:

Total NACK to any of this boolean ididocy.  I very much hope you didn't
get the impression you actually have a chance to get this merged.

> 
> * (Most importent, may introduce bugs if left alone)
> Fixing boolean checking, ex:
> if (bool == FALSE)
> to
> if (!bool)

this one of course makes sense, but please do it without introducing
any boolean type.  Getting rid of all the TRUE/FALSE defines and converting
all scsi drivers to classic C integer as boolean semantics would be
very welcome janitorial work.

