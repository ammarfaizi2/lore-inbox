Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263119AbVCEPwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbVCEPwq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVCEPrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:47:20 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:62647 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262111AbVCEPl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:41:56 -0500
Message-ID: <4229D342.7030705@acm.org>
Date: Sat, 05 Mar 2005 09:41:54 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bene Martin <martin.bene@icomedias.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: ipmi in kernel 2.6.11
References: <FA095C015271B64E99B197937712FD02510ACF@freedom.grz.icomedias.com>
In-Reply-To: <FA095C015271B64E99B197937712FD02510ACF@freedom.grz.icomedias.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bene Martin wrote:

>Hi Adrian,
>
>bmcsensors package (reading hardware sensors provided by intel boards
>via ipmi) used to work fine with 2.6.10; no longer works with 2.6.11
>because of removal of the ipmi_request function (+ exported symbol).
>
>correct fix would be to use ipmi_request_settime with retries=-1 and
>retry_time_ms=0?
>  
>
That fix should work fine.  Sorry about that, I didn't know anyone was 
using that function, and the unused function police found it :).

-Corey
