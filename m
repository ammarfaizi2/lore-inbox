Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbVCJUFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbVCJUFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbVCJUAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:00:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:50951 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261713AbVCJTwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:52:24 -0500
Date: Thu, 10 Mar 2005 20:52:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Anil Kumar <anilsr@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: driver compile parse errors for RHEL4
Message-ID: <20050310195218.GD30052@alpha.home.local>
References: <d3a6bba0050310112514a8e924@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a6bba0050310112514a8e924@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 11:25:34AM -0800, Anil Kumar wrote:
 
> The errors are as follows:
> 
> drivers/scsi/aic7xxx/aic7xxx_reg_print.c:23: error: parse error before '(' token
> drivers/scsi/aic7xxx/aic7xxx_reg_print.c:40: error: parse error before '(' token
> drivers/scsi/aic7xxx/aic7xxx_reg_print.c:57: error: parse error before '(' token
> drivers/scsi/aic7xxx/aic7xxx_reg_print.c:82: error: parse error before '(' token
> 

It looks like some trouble I encountered recently when porting old programs
to gcc-3, which was caused by abusive use of '##' in macros. The error even
changed when I inserted a space before the opening parenthesis !

> Can you please let me know if my gcc is installed correctly, I mean if
> I disable/enable any of the flags. If not I will look into my
> Makefiles and scripts.

You should have started from here, otherwise I guess you will not receive
many responses.

Willy

