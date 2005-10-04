Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVJDJeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVJDJeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 05:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVJDJeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 05:34:15 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:58125 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751196AbVJDJeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 05:34:15 -0400
From: Felix Oxley <lkml@oxley.org>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: make xconfig fails for older kernels
Date: Tue, 4 Oct 2005 10:34:05 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org
References: <4TJDn-2mm-3@gated-at.bofh.it> <4341FBA8.3020208@shaw.ca>
In-Reply-To: <4341FBA8.3020208@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041034.07837.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 04:48, Robert Hancock wrote:

> What gcc version? The configuration program may have had some compile
> bugs with newer compilers that were fixed in later kernels. In
> particular I think gcc4 is stricter about those "static declaration
> follows non-static" problems.

I think you have nailed it.  I'm using GCC 4.0.2. 
Incidentally the first 2.6 kernel in which this issue was resolved is 2.6.9.
I will install GCC 2.9.5.

Thanks to all.
Felix

