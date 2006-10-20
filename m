Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWJTJHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWJTJHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWJTJHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:07:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6089 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932230AbWJTJHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:07:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OAXLrrSmC/NcYCO2JzcY10Inlt2vl2IAi1qDPAV1G8x0FWTUuUIhf8B80MY1epCswA/lTqznWo2ZONIGGR6HCByl/f5lBJQVM+UXntQEXIDCpSzIyZAcFvXwgkimYpuG2k79eAc453xMHS+Kd26mMFESaD9DPrBiJQO7d0S79Oc=
Message-ID: <453891AD.70704@gmail.com>
Date: Fri, 20 Oct 2006 18:06:53 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org
Subject: Re: [patch] libata: use correct map_db values for ICH8
References: <20061019132739.10e504ef.kristen.c.accardi@intel.com>
In-Reply-To: <20061019132739.10e504ef.kristen.c.accardi@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Kristen.

Kristen Carlson Accardi wrote:
> Use valid values for ICH8 map_db.  With the old values, when the 
> controller was in Native mode, and SCC was 1 (drives configured for
> IDE), any drive plugged into a slave port was not recognized.  For
> Combined Mode (and SCC is still 1), 2 is a value value for MAP.map_value,
> and needs to be recognized.
> 
> Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Do you guys have doc update related to this?  The doc and spec update 
still indicate that MAP value is reserved to 00b.  Anyways, if you say 
that's right...

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
