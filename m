Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUFNITk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUFNITk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUFNITO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:19:14 -0400
Received: from [213.146.154.40] ([213.146.154.40]:22993 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262060AbUFNINL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:13:11 -0400
Date: Mon, 14 Jun 2004 09:13:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [6/12] fix advansys.c highmem bugs
Message-ID: <20040614081306.GE7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003929.GU1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:39:29PM -0700, William Lee Irwin III wrote:
>  * Added basic highmem support in drivers/scsi/advansys.c
> This fixes Debian BTS #245238.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=245238
> 
> 	From: "Jamin W. Collins" <jcollins@asgardsrealm.net>
> 	To: Debian Bug Tracking System <submit@bugs.debian.org>
> 	Message-Id: <E1BGVXw-0000GD-LF@thor.asgardsrealm.net>
> 	Subject: kernel-image-2.6.5-1-k7: fails to boot with "request_module: runaway loop modprobe binfmt-0000"
> 
> Attempting to boot my system after installing the
> kernel-image-2.6.5-1-k7 package fails with the following errors:
> 
> request_module: runaway loop modprobe binfmt-0000
> request_module: runaway loop modprobe binfmt-0000
> request_module: runaway loop modprobe binfmt-0000
> request_module: runaway loop modprobe binfmt-0000
> 
> The system boots fine from a 2.4.24 kernel and used to boot properly
> from a custom 2.6.3 kernel.  After taking hte system down to add more
> memory, I noticed the above error with my custom 2.6.3 kernel and
> reverted to the 2.4.24.  I've since removed the custom 2.6.3 and
> installed the Debian 2.6.5.

An improved version of this already is in the linux-scsi tree.

