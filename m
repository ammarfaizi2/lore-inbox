Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWFXSRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWFXSRI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWFXSRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:17:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:10930 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751023AbWFXSRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:17:07 -0400
Date: Sat, 24 Jun 2006 19:17:02 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel <damage@rooties.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernelsources writeable for everyone?!
Message-ID: <20060624181702.GG27946@ftp.linux.org.uk>
References: <200606242000.51024.damage@rooties.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606242000.51024.damage@rooties.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 08:00:50PM +0200, Daniel wrote:
> Hi,
> may be this was reported/asked 999999999 times, but here ist the 1000000000th:
> 
> I have downloaded linux-2.6.17.1 10 min ago and I noticed that every file is 
> writeable by everyone. What's going on there?

You are unpacking tarballs as root and preserve ownership and permissions.
Don't.
