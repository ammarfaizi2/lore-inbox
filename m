Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbTJIUrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTJIUrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:47:33 -0400
Received: from intra.cyclades.com ([64.186.161.6]:10929 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262501AbTJIUrb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:47:31 -0400
Date: Thu, 9 Oct 2003 17:47:19 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG() in exec_mmap()
In-Reply-To: <3F85C875.2030506@kolumbus.fi>
Message-ID: <Pine.LNX.4.44.0310091746540.3040-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Oct 2003, Mika Penttilä wrote:

> Hmm.. you still need to mmput(old_mm) etc, just remove the mm_users == 1 
> optimization from the beginning of exec_mmap, so this patch is wrong!

Right. Ill fix it up by hand.

