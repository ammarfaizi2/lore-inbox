Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWGSXxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWGSXxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 19:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWGSXxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 19:53:01 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:58497 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964878AbWGSXxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 19:53:00 -0400
Message-ID: <44BEC5DA.4020807@bigpond.net.au>
Date: Thu, 20 Jul 2006 09:52:58 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se> <20060719212049.GA6828@martell.zuzino.mipt.ru> <1153349221.44beb6653e039@portal.student.luth.se>
In-Reply-To: <1153349221.44beb6653e039@portal.student.luth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 19 Jul 2006 23:52:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se wrote:
> Citerar Alexey Dobriyan <adobriyan@gmail.com>:
>> Please, show compiler flag[s] to enable warning[s] from gcc about
>>
>> 	_Bool foo = 42;
>>
>> Until you do that the whole activity is moot.
> On it...

Would not the compiler treat 42 as a Boolean expression (as opposed to 
an integer expression) that evaluates to true and set foo accordingly. 
I.e. there's only a problem here if foo ends up with the value 42 
instead of the value true.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
