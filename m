Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUEJUpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUEJUpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUEJUpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:45:11 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:56194 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261582AbUEJUpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:45:08 -0400
Date: Mon, 10 May 2004 22:44:50 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com
Subject: Re: Linux 2.6.6
Message-ID: <20040510204450.GA2758@louise.pinerecords.com>
References: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org> <20040510105129.GB25969@picchio.gall.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510105129.GB25969@picchio.gall.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May-10 2004, Mon, 12:51 +0200
Daniele Venzano <webvenza@libero.it> wrote:

> I have problems booting 2.6.6 (2.6.5 was fine). The boot stops at ide
> detection, on cdrom probing, the last two messages I am seeing are:
> 
> ide-cd: cmd 0x5a timed out
> hdc: lost interrupt

This problem also affects my 2001 1.0 GHz Athlon box (VIA KT133a chipset).
Len's final patch (proposed fix) from the "hdc: lost interrupt..." thread
seems to work for me, too.

-- 
Tomas Szepe <szepe@pinerecords.com>
