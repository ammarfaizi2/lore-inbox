Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWF2GXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWF2GXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 02:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWF2GXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 02:23:16 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:5785 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932582AbWF2GXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 02:23:14 -0400
Date: Thu, 29 Jun 2006 08:23:05 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, vs@namesys.com, neilb@suse.de,
       schwidefsky@de.ibm.com, stable@kernel.org
Subject: Re: Unkillable process in last git -- Bisected
Message-ID: <20060629082305.60350874@localhost>
In-Reply-To: <20060628222036.e4e40bab.akpm@osdl.org>
References: <20060628142918.1b2c25c3@localhost>
	<20060628145349.53873ccc@localhost>
	<20060628150943.78e91871@localhost>
	<20060628151955.0acdb39a@localhost>
	<20060628203825.47790a10@localhost>
	<20060628222036.e4e40bab.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 22:20:36 -0700
Andrew Morton <akpm@osdl.org> wrote:

> From: Andrew Morton <akpm@osdl.org>
> 
> The recent generic_file_write() deadlock fix caused
> generic_file_buffered_write() to loop inifinitely when presented with a
> zero-length iovec segment.  Fix.

It works for me :)

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
