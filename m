Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSGATmB>; Mon, 1 Jul 2002 15:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSGATmA>; Mon, 1 Jul 2002 15:42:00 -0400
Received: from e.kth.se ([130.237.48.5]:27153 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S316585AbSGATl6>;
	Mon, 1 Jul 2002 15:41:58 -0400
To: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Diff b/w 32bit & 64-bit
References: <5F0021EEA434D511BE7300D0B7B6AB5303C78735@mail2.ggn.hcltech.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 01 Jul 2002 21:44:13 +0200
In-Reply-To: "Mohamed Ghouse , Gurgaon"'s message of "Mon, 1 Jul 2002 15:53:21 +0530"
Message-ID: <yw1xpty71bea.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com> writes:

> Hello All
>  I am working on a Driver.
> Considering the processor 2 B Intel's x86, 
> can some one enlighten me with the differences of Linux on a 64-bit
> processor & a 32-Bit processor.

For Alpha: sizeof(int) == 4, sizeof(long) == 8, sizeof(void *) == 8
For intel: sizeof(int) == 4, sizeof(long) == 4, sizeof(void *) == 8

The most common mistake is trying to stuff a pointer into an
int. Don't do that.

-- 
Måns Rullgård
mru@users.sf.net
