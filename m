Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269584AbUJFWlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269584AbUJFWlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbUJFWlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:41:08 -0400
Received: from blanca.radiantdata.com ([64.207.39.196]:29259 "EHLO
	blanca.peakdata.loc") by vger.kernel.org with ESMTP id S269584AbUJFWhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:37:50 -0400
X-SMSMSE-SCL: 9
thread-index: AcSr9WAFPVVtuynLRGClmagDjxEh6g==
Thread-Topic: Possible Spam:Re: Problems in list.h macros?
Message-ID: <416473FE.5030309@radiantdata.com>
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.132
Date: Wed, 06 Oct 2004 16:38:54 -0600
From: "Peter W. Morreale" <morreale@radiantdata.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stuart MacDonald" <stuartm@connecttech.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Possible Spam:Re: Problems in list.h macros?
References: <030801c4abeb$c9316ba0$294b82ce@stuartm>
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2004 22:39:43.0937 (UTC) FILETIME=[60031B10:01C4ABF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From list.h:

 * list_for_each_safe   -       iterate over a list safe against removal 
of list entry

It's only safe to remove entries.    

-PWM



Stuart MacDonald wrote:

>I am referring to a stock 2.4.27's linux/list.h.
>
>1: list_for_each(_entry)_safe() calls seem not to be as safe as they
>are implied to be. They seem to be only actually safe *iff* a
>list_del() is the only operation performed on the list entry. If pos
>is freed after a list_del, aren't you toast? If n has its pointers
>modified, say by a list_add() to a different list, don't you end up
>at the new list instead of the original list? Shouldn't this be noted
>in the macro comments?
>
>..Stu
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>



