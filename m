Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUHIPp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUHIPp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUHIPm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:42:56 -0400
Received: from [213.146.154.40] ([213.146.154.40]:57041 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266303AbUHIPkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:40:31 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: David Woodhouse <dwmw2@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, James.Bottomley@steeleye.com,
       eric@lammerts.org, linux-kernel@vger.kernel.org
In-Reply-To: <200408091421.i79ELiPS010580@burner.fokus.fraunhofer.de>
References: <200408091421.i79ELiPS010580@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1092066015.4383.5344.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 09 Aug 2004 16:40:15 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 16:21 +0200, Joerg Schilling wrote:
> Please try again after you had a look into the cdrtools sources.

Jrg, you are making a fool of yourself.

> Cdrecord also needs privilleges to lock memory and to raise prioirity.

Wrong. Cdrecord does not always _need_ to lock memory or to raise its
priority.

To do so may be useful when using older drives without buffer underrun
protection, but is not strictly necessary on current hardware. 

> Jrg

-- 
dwmw2

