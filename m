Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFNAfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFNAfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFNAfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:35:38 -0400
Received: from urchin.mweb.co.za ([196.2.24.26]:48852 "EHLO urchin.mweb.co.za")
	by vger.kernel.org with ESMTP id S261409AbVFMVis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:38:48 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Tracking a bug in x86-64
Date: Mon, 13 Jun 2005 23:39:13 +0200
User-Agent: KMail/1.8.50
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <200506132259.22151.bonganilinux@mweb.co.za>
In-Reply-To: <200506132259.22151.bonganilinux@mweb.co.za>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506132339.13614.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 10:59 pm, Bongani Hlope wrote:
> Hi Andrew and Andi
> 
> I've been trying to track dow an bug that causes my userspace applications to 
> randomly segfault. I've tracked it down to 2.6.11-mm4 (I'm not sure about mm[1-3]).  
> The bug does not exist in the 2.6.11 kernel. The 2.6.12-rc1 kernel has the bug. The bug 
> is easly triggered by compiling KDE or the kernel using make -j4
> 

I've just tested 2.6.11-mm1 it has that bug as well. So the bug was introduced on that kernel.
