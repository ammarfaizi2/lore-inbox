Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUHOJMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUHOJMF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 05:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266565AbUHOJMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 05:12:05 -0400
Received: from tristate.vision.ee ([194.204.30.144]:58591 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S266561AbUHOJMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 05:12:02 -0400
Message-ID: <411F28D6.9000005@vision.ee>
Date: Sun, 15 Aug 2004 12:11:50 +0300
From: =?UTF-8?B?TGVuYXIgTMO1aG11cw==?= <lenar@vision.ee>
Organization: Vision
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Sylvain COUTANT <sylvain.coutant@illicom.com>,
       "'Matt Domsch'" <Matt_Domsch@dell.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: High CPU usage (up to server hang) under heavy I/O load
References: <20040813154737.7DCC12FC2C@illicom.com> <1092454748.3816.11.camel@localhost.localdomain>
In-Reply-To: <1092454748.3816.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:

>On Fri, 2004-08-13 at 11:46, Sylvain COUTANT wrote:
>  
>
>During heavy writes to the drives attached to the PERC4/Di the system
>becomes practically unusable.  I've been wanting to try the 'megaraid2'
>driver to see if this gets rid of the issue but I haven't been able to
>try that yet.
>  
>
Can confirm same symptoms. But I can say that megaraid2 driver gets rid 
of this slowdown
(during heavy writing). Only problem you can't use dellmgr or megamon 
with this driver it seems.

>We have some older systems with PERC2/DC cards which also use the
>'megaraid' driver but they don't seem to experience this issue so I'm a
>little suspicious that perhaps this driver simply doesn't work that well
>with the newer megaraid-like controllers.
>  
>
It's PERC3/QC here.

Lenar

