Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWF1SoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWF1SoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWF1SoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:44:19 -0400
Received: from gw.goop.org ([64.81.55.164]:57299 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750794AbWF1SoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:44:18 -0400
Message-ID: <44A2CE04.80606@goop.org>
Date: Wed, 28 Jun 2006 11:44:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.17-mm3: segvs in modpost with out-of-tree modules
References: <44A2B37F.4030500@goop.org> <20060628112925.f96fcfc4.akpm@osdl.org>
In-Reply-To: <20060628112925.f96fcfc4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 28 Jun 2006 09:51:11 -0700
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>   
>> I haven't really looked at yet, but I was hoping someone had already 
>> tracked it down.
>>     
>
> Not that I'm aware of.

OK, it wasn't really a bug; I had an old Modules.symvers lying around 
the madwifi tree from a previous build against an earlier kernel.  But 
modpost seems all pretty fragile...

    J
