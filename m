Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbTFVSf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbTFVSf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:35:58 -0400
Received: from pl266.nas911.n-yokohama.nttpc.ne.jp ([210.139.38.10]:64963 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id S264977AbTFVSfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:35:53 -0400
Message-ID: <3EF5FA7A.46A6CF88@yk.rim.or.jp>
Date: Mon, 23 Jun 2003 03:50:34 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Michael Buesch <fsdeveloper@yahoo.de>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Warning messages during compilation of 2.4.21. (5 files)
References: <3EF4B98D.33A55CD1@yk.rim.or.jp> <200306221343.26884.fsdeveloper@yahoo.de> <3EF5B80C.7F5340F7@yk.rim.or.jp> <200306221658.36409.fsdeveloper@yahoo.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:

> What about adding something like that:
> #if MAX_NR_FUNC < 256
>         if((int)tmp.kb_func >= MAX_NR_FUNC)
>                 return -EINVAL;
> #endif
> 
> Sure, this is ugly, too, but I think the warning is
> _very_ ugly. Another solution is, what you already
> said, to completely remove this if ().
> 

This looks good enough to me.

BTW, I tried to send the info to jhartmann@... mentioned
in agpgart_be.c. But he is no longer at
the e-mail address and the e-mail bounced.
I wonder if anyone knows how to send the message
to him today.

-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
