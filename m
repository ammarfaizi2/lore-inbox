Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933186AbWKWIMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933186AbWKWIMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933169AbWKWIMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:12:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6855 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933156AbWKWIMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:12:31 -0500
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to
	implicate xfs, scsi, networking, SMP
From: Arjan van de Ven <arjan@infradead.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, dgc@sgi.com, jesper.juhl@gmail.com,
       chatz@melbourne.sgi.com, linux-kernel@vger.kernel.org, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20061123043543.GI3078@ftp.linux.org.uk>
References: <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com>
	 <9a8748490611220458w4d94d953v21f7a29a9f1bdb72@mail.gmail.com>
	 <20061123011809.GY37654165@melbourne.sgi.com>
	 <20061122.201013.112290046.davem@davemloft.net>
	 <20061123043543.GI3078@ftp.linux.org.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 23 Nov 2006 09:12:25 +0100
Message-Id: <1164269545.31358.771.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 04:35 +0000, Al Viro wrote:
> > I would even say 10 function calls deep to allocate file blocks
> > is overkill, but 22 it just astronomically bad.
> 
> Especially since a large part is due to cxfs...
> -

it's a bit sad to see XFS this crippled in linux due to an external,
proprietary module ;(

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

