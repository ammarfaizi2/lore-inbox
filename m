Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262764AbREaHKJ>; Thu, 31 May 2001 03:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262767AbREaHJ6>; Thu, 31 May 2001 03:09:58 -0400
Received: from t2.redhat.com ([199.183.24.243]:58358 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262764AbREaHJj>; Thu, 31 May 2001 03:09:39 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200105302301.QAA08564@csl.Stanford.EDU> 
In-Reply-To: <200105302301.QAA08564@csl.Stanford.EDU> 
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 2.4.5-ac4 non-init functions calling init functions 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 May 2001 08:09:05 +0100
Message-ID: <9262.991292945@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


engler@csl.Stanford.EDU said:
>  It's a space/performance bug, though, right?  From the original mail:
>         1. The best case: the caller should actually be an __init function
>         as well.  This is a performance bug since it won't be freed. 

Yes, sorry. I hadn't properly read the beginning or your mail - I'd skipped 
straight to checking whether anything I own had been listed. :)

--
dwmw2


