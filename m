Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVDDUSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVDDUSG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVDDUO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:14:27 -0400
Received: from main.gmane.org ([80.91.229.2]:47567 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261373AbVDDUNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:13:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: PCI: increase the size of the pci.ids strings
Date: Mon, 4 Apr 2005 22:11:03 +0200
Message-ID: <1sz3rs1pu3xeo$.18czc0ok953h5$.dlg@40tude.net>
References: <20050401234550.GA15046@kroah.com> <11123992681543@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-115-253.37-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2005 15:47:48 -0800, Greg KH wrote:

> -#define PCI_NAME_SIZE	96
> +#define PCI_NAME_SIZE	255
>  #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */

Shouldn't PCI_NAME_HALF be changed too? To something like 109 or 113?

-- 
Giuseppe "Oblomov" Bilotta

Axiom I of the Giuseppe Bilotta
theory of IT:
Anything is better than MS

