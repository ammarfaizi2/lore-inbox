Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWJBCfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWJBCfj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 22:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWJBCfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 22:35:39 -0400
Received: from 205-200-74-130.static.mts.net ([205.200.74.130]:14722 "EHLO
	Zimmer.boxheap.net") by vger.kernel.org with ESMTP id S932602AbWJBCfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 22:35:39 -0400
Date: Sun, 1 Oct 2006 22:35:11 -0500
From: Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20061002033511.GB12695@zimmer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppmd, also in Debian had better compression than lzma. PAQ8i has even
better compression, but isn't in Debian. See the maximumcompression web
site or other archive comparison tests.

The pace of compression algorithm development is high enough that I'd
suggest that the bar be placed quite high before switching to a new
compression format that's not reverse compatible.

For those interested, I'm working on publishing a proof of concept that 
can make most tarballs compress better. About 2-3% better in my tests 
with bzip2/gzip on the Linux kernel source code.

     Drew Daniels
Resume: http://www.boxheap.net/ddaniels/resume.html

