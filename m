Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVL2LBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVL2LBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVL2LBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:01:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:2203 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932584AbVL2LA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:00:59 -0500
Date: Thu, 29 Dec 2005 11:00:54 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "pretorious ." <pretorious_i@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Redefinition error while compiling LKM
Message-ID: <20051229110054.GI27946@ftp.linux.org.uk>
References: <BAY23-F21B799C42BAB6D34C0D762F7290@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY23-F21B799C42BAB6D34C0D762F7290@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 04:21:49PM +0530, pretorious . wrote:
> hi!
>   I am facing problem in compiling an LKM. It seems Inclusion of 
> <sys/stat.h> conflicts with definitions in time.h.

That's because you do not use libc headers for non-userland code...
