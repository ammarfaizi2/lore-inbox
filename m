Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbULXLBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbULXLBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 06:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbULXLBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 06:01:33 -0500
Received: from viefep13-int.chello.at ([213.46.255.15]:65077 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id S261388AbULXLBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 06:01:32 -0500
Subject: Re: USB storage (pendrive) problems
From: Attila BODY <compi@freemail.hu>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041221131534.411e3553@lembas.zaitcev.lan>
References: <1103579679.23963.14.camel@localhost>
	 <200412202325.20064.andrew@walrond.org> <41C75E8B.1020200@osdl.org>
	 <mailman.1103615580.2095.linux-kernel2news@redhat.com>
	 <20041221131534.411e3553@lembas.zaitcev.lan>
Content-Type: text/plain
Date: Fri, 24 Dec 2004 12:23:04 +0100
Message-Id: <1103887384.10838.1.camel@thunder>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2004-12-21 at 13:15 -0800, Pete Zaitcev wrote:

> Thanks for the note. Unfortunately, 2.6.9 apparently has problems with
> its virtual memory and write throttling, so I'm sure a few people suffering
> from it will jump on this thread. It's essential to split root causes.
> Your case may be different from the original poster's, who apparently
> had the same deal with both ub and usb-storage. First things first, did
> you try to set CONFIG_BLK_DEV_UB to off? What happens if you do?

It works then, so the problem seems to be with the ub driver, but it is
still a question why the 1.1 device seems to wprk better with it.

brgds,

compi


