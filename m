Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWF0Pjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWF0Pjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbWF0Pjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:39:48 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:41668 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161105AbWF0Pjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:39:47 -0400
Subject: Re: Areca driver recap + status
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Mueller <robm@fastmail.fm>, Andrew Morton <akpm@osdl.org>,
       rdunlap@xenotime.net, hch@infradead.org, erich@areca.com.tw,
       brong@fastmail.fm, dax@gurulabs.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <1151423500.32186.39.camel@localhost.localdomain>
References: <09be01c695b3$2ed8c2c0$c100a8c0@robm>
	 <20060621222826.ff080422.akpm@osdl.org>
	 <1151333338.2673.4.camel@mulgrave.il.steeleye.com>
	 <057801c69970$70b45090$0e00cb0a@robm>
	 <1151422074.3340.25.camel@mulgrave.il.steeleye.com>
	 <1151423500.32186.39.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 10:39:27 -0500
Message-Id: <1151422767.3340.29.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 16:51 +0100, Alan Cox wrote:
> On x86_64 the dma_addr_t and the ulong are both 64bit so the problem
> doesn't arise. 

Yes it does ... apparently 32 bit kernel on x86_64 is a lot more common
than people suppose.  In > 4GB this is exactly PAE.

James


