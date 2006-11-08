Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965693AbWKHMzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965693AbWKHMzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965694AbWKHMzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:55:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25522 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965693AbWKHMzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:55:14 -0500
Subject: Re: invalidate/drop filesystem caches & io buffers
From: Arjan van de Ven <arjan@infradead.org>
To: Yakov Lerner <iler.ml@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f36b08ee0611080453p5401de04td2fef8bff4d0efb3@mail.gmail.com>
References: <f36b08ee0611080453p5401de04td2fef8bff4d0efb3@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 13:55:12 +0100
Message-Id: <1162990512.3138.318.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 14:53 +0200, Yakov Lerner wrote:
> I'd like to invalidate/free the filesystem caches and io buffer cache
> How can I do this when I can't unmount the filesystem (and w/o reboot) ?


echo 1 > /proc/sys/vm/drop_caches

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

