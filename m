Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWACTOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWACTOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWACTOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:14:52 -0500
Received: from quark.didntduck.org ([69.55.226.66]:11970 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751459AbWACTOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:14:51 -0500
Message-ID: <43BACD20.8050601@didntduck.org>
Date: Tue, 03 Jan 2006 14:14:40 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/26] gitignore: x86_64 files
References: <20060103132035.GA17485@mars.ravnborg.org>	<11362947263966@foobar.com> <p73wthhi7v9.fsf@verdi.suse.de>
In-Reply-To: <p73wthhi7v9.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> 
>>From: Brian Gerst <bgerst@didntduck.org>
>>Date: 1135744791 -0500
>>
>>Add filters for x86_64 generated files.
> 
> 
> Please don't submit this patch. If anything such ignore lists
> for specific SVMs should be in a central place, but not spread
> everywhere.
> 

It makes good sense to have .*ignore files in the same directory as the 
Makefile that produces the ignored files.  They are more likely to be 
maintained when they are in the same location.

Git is the SCM du jour for kernel work.  If you chose to use another SCM 
then these files don't hinder you at all.

--
				Brian Gerst
