Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUBTIdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 03:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267738AbUBTIdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 03:33:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31248 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267733AbUBTIdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 03:33:09 -0500
Date: Fri, 20 Feb 2004 08:33:06 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Marc Singer <elf@buici.com>
Cc: linux-kernel@vger.kernel.org, linux-arm <linux-arm@lists.arm.linux.org.uk>
Subject: Re: New 2.6 port: why would kernel not start /sbin/init?
Message-ID: <20040220083306.C22236@flint.arm.linux.org.uk>
Mail-Followup-To: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org,
	linux-arm <linux-arm@lists.arm.linux.org.uk>
References: <20040220043819.GA9592@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040220043819.GA9592@buici.com>; from elf@buici.com on Thu, Feb 19, 2004 at 08:38:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 08:38:19PM -0800, Marc Singer wrote:
> My hardware debugger complains of a 'data abort' when I look at that
> address which usually means that the CPU returned a page fault.
> 
> Should I expect that these pages be mapped already?

No.  Pages are faulted in as required.
