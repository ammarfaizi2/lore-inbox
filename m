Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVBLDlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVBLDlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVBLDfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:35:24 -0500
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:18383 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S262395AbVBLDcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:32:50 -0500
Subject: Re: Using O_DIRECT for file writing in a kernel module
From: Arjan van de Ven <arjan@infradead.org>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C20639287E@azsmsx406>
References: <C863B68032DED14E8EBA9F71EB8FE4C20639287E@azsmsx406>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 22:32:44 -0500
Message-Id: <1108179164.4055.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2005 03:32:45.0845 (UTC) FILETIME=[84855C50:01C510B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 17:58 -0700, Hanson, Jonathan M wrote:
> 	I'm trying to write to a file with the O_DIRECT flag from a
> kernel module in a 2.4 series of kernel on x86 hardware. I've learned
> that the O_DIRECT flag requires that the amount of data written and the
> file offset pointer must be multiples of the underlying "block size."


ehhh why are you writing to a file from a kernel module? That's
generally considered a really bad idea....


