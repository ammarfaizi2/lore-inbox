Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263894AbTCWVda>; Sun, 23 Mar 2003 16:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263923AbTCWVd3>; Sun, 23 Mar 2003 16:33:29 -0500
Received: from vitelus.com ([64.81.243.207]:46606 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S263894AbTCWVd3>;
	Sun, 23 Mar 2003 16:33:29 -0500
Date: Sun, 23 Mar 2003 13:43:57 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp overhead, and rwlocks considered harmful
Message-ID: <20030323214357.GA22181@vitelus.com>
References: <20030322175816.225a1f23.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322175816.225a1f23.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 05:58:16PM -0800, Andrew Morton wrote:
> 
> I've been looking at the CPU cost of the write() system call.  Time how long
> it takes to write a million bytes to an ext2 file, via a million
> one-byte-writes:

Are you using a sysenter-capable C library?
