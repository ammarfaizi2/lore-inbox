Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269207AbUJFLgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbUJFLgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 07:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269210AbUJFLgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 07:36:33 -0400
Received: from smtp.poczta.interia.pl ([217.74.65.43]:62530 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S269207AbUJFLgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 07:36:31 -0400
Message-ID: <4163D8BB.8080507@interia.pl>
Date: Wed, 06 Oct 2004 13:36:27 +0200
From: Patryk Jakubowski <patrics@interia.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Invisible threads in 2.6.9
References: <S268296AbUJDTjb/20041004193948Z+2396@vger.kernel.org> <41630B2C.5020709@interia.pl> <4163619C.4070600@vgertech.com> <4163A3E2.2060609@stud.feec.vutbr.cz> <4163C574.50805@interia.pl> <20041006110721.GC4380@vana.vc.cvut.cz>
In-Reply-To: <20041006110721.GC4380@vana.vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: 20abaacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

>ChangeSet@1.1832.29.23, 2004-08-27 10:34:04-07:00, roland@redhat.com
>  [PATCH] fix MT reparenting when thread group leader dies
>
>but it is possible that it worked before that patch and this one
>actually rebroke it.
>
>/proc/<tid> is visible because of:
>
>ChangeSet@1.1371.477.18, 2004-03-01 23:03:02-08:00, akpm@osdl.org
>  [PATCH] revert the /proc thread visibility fix
>
>which was needed to get gdb to work.
>							Petr
>
>
>  
>
I think this should be fixed in stable kernel version, but it isn't. I 
have consulted this problem in a forum. Few people can reproduce the 
bug. They have kernels 2.6.7, 2.6.8. I am pretty sure I have kernel 
2.6.9-rc3 from kernel.org :) I downloaded it to check if the bug is not 
fixed.

       Pat


----------------------------------------------------------------------
Portal INTERIA.PL zaprasza... >>> http://link.interia.pl/f17cb

