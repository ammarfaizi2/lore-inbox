Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVCRAI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVCRAI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCRAI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:08:57 -0500
Received: from li-22.members.linode.com ([64.5.53.22]:14996 "EHLO
	www.cryptography.com") by vger.kernel.org with ESMTP
	id S261395AbVCRAIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:08:52 -0500
Message-ID: <423A1BED.1010608@root.org>
Date: Thu, 17 Mar 2005 16:08:13 -0800
From: Nate Lawson <nate@root.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] IDE failure on ACPI resume
References: <1110741241.8136.46.camel@tyrosine>  <423518E7.3030300@root.org>	 <1111072221.8136.171.camel@tyrosine>  <4239E9BA.7050105@root.org> <1111104154.8136.179.camel@tyrosine>
In-Reply-To: <1111104154.8136.179.camel@tyrosine>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Thu, 2005-03-17 at 12:34 -0800, Nate Lawson wrote:
>>Very interesting.  I was hoping to someday have _GTF et al implemented 
>>but the ATA knowledge required was above my head.  I also strongly 
>>suspected that the info published by _GTF would likely be invalid.  Does 
>>Windows actually use that method or just hardcoded ATA initialization?
> 
> I believe that Windows does use the _GTF methods.

You are correct.  A quick scan of my w2k drivers shows atapi.sys uses 
the _GTF, _GTM, and _STM methods.

-- 
Nate
