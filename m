Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbTIDQA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTIDQA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:00:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:57475 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265078AbTIDQAZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:00:25 -0400
Date: Thu, 4 Sep 2003 09:01:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Breno" <brenosp@brasilsec.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pte_offset  and pte_offset_map
Message-Id: <20030904090106.59c98ee3.akpm@osdl.org>
In-Reply-To: <000f01c38b4f$67dfbfe0$c5e4a7c8@bsb.virtua.com.br>
References: <000f01c38b4f$67dfbfe0$c5e4a7c8@bsb.virtua.com.br>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Breno" <brenosp@brasilsec.com.br> wrote:
>
> pte_offset() in 2.4 is the same as pte_offset_map in 2.6 ?

Yes.

> What´s PageCompound bit flag ?

It indicates that the page is part of a "higher order" allocation: It was
obtained via a 2, 4, 8...  page allocation.

