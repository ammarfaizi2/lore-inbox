Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbTIAAhw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbTIAAhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:37:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21897 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263097AbTIAAhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:37:51 -0400
Date: Mon, 1 Sep 2003 01:37:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901003750.GB31531@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030901002412.GA16537@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901002412.GA16537@linux-sh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:
> sh (VIPT cache):
> 
> Test separation: 4096 bytes: FAIL - cache not coherent
> Test separation: 8192 bytes: FAIL - cache not coherent
> Test separation: 16384 bytes: pass

A VIVT cache can do that, but I think a VIPT cache should always be coherent.
Do I misunderstand?

-- Jamie
