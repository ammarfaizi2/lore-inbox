Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVDHKgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVDHKgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVDHKgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:36:24 -0400
Received: from gate.corvil.net ([213.94.219.177]:15123 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262746AbVDHKcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:32:39 -0400
Message-ID: <42565DB8.4060006@draigBrady.com>
Date: Fri, 08 Apr 2005 11:32:24 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Wilson <njw@osdl.org>, linux-kernel@vger.kernel.org,
       rddunlap@osdl.org
Subject: Re: [PATCH 0/6] add generic round_up_pow2() macro
References: <20050408004428.GA4260@njw.pdx.osdl.net> <20050407175042.43c02ae9.akpm@osdl.org> <42565587.4000103@draigBrady.com>
In-Reply-To: <42565587.4000103@draigBrady.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P@draigBrady.com wrote:
> Andrew Morton wrote:
> 
>> Nick Wilson <njw@osdl.org> wrote:
>>
>>> The first patch adds a generic round_up_pow2() macro to kernel.h. The
>>> remaining patches modify a few files to make use of the new macro.
>>
>>
>>
>> We already have ALIGN() and roundup_pow_of_two().
> 
> 
> cool. It doesn't handle x={0,1} though.

Well I should clarify.
2^0==1 is a special case that you probably
don't want as a result from the macro?

-- 
Pádraig Brady - http://www.pixelbeat.org
--
