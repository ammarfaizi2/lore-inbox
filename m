Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317709AbSGVRfl>; Mon, 22 Jul 2002 13:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317715AbSGVRfk>; Mon, 22 Jul 2002 13:35:40 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:7431 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317709AbSGVRfk>; Mon, 22 Jul 2002 13:35:40 -0400
Date: Mon, 22 Jul 2002 18:38:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Dike <jdike@karaya.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       jdike@ccure.karaya.com
Subject: Re: [PATCH] UML - part 1 of 2
Message-ID: <20020722183844.A8526@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Dike <jdike@karaya.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, jdike@ccure.karaya.com
References: <200207221715.MAA03040@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207221715.MAA03040@ccure.karaya.com>; from jdike@karaya.com on Mon, Jul 22, 2002 at 12:15:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 12:15:29PM -0500, Jeff Dike wrote:
> include/linux/linkage.h -
> 	UML needs FASTCALL defined as regparm(3), too.

The fastcall definition should go into an asm/ header instead of such hacks..

the disk accounting stuff is also bogus - instead of wasting ram with
huge array it should rather be dynamically-allocated in a per-disk
structure..

