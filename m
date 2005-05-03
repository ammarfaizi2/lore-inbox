Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVECKpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVECKpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 06:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVECKpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 06:45:31 -0400
Received: from animx.eu.org ([216.98.75.249]:37767 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261444AbVECKp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 06:45:27 -0400
Date: Tue, 3 May 2005 06:45:03 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-ID: <20050503104503.GA11123@animx.eu.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050503012951.GA10459@animx.eu.org> <20050502193503.20e6ac6e.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502193503.20e6ac6e.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Mon, 2 May 2005 21:29:51 -0400 Wakko Warner wrote:
> | Is it possible to use zImage on 2.6 kernels or is bzImage required?
> 
> What processor architecture?

x86.  Does zImage work on other arches?  (I've only ever dealt with alpha
and sparc other than x86)

> It's supported in arch/i386/Makefile (and some others).
> For i386, you'll need to disable enough (lots of) options to make the
> resulting output file small enough...

The resultant bzImage is ~760kb.  I compiled out everything I could, only
ram disk/initrd, and ext2 are compiled in.

If you'd like to see the .config, I'll send it up.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
