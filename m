Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVCQUhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVCQUhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVCQUhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:37:15 -0500
Received: from li-22.members.linode.com ([64.5.53.22]:62609 "EHLO
	www.cryptography.com") by vger.kernel.org with ESMTP
	id S261156AbVCQUhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:37:11 -0500
Message-ID: <4239E9BA.7050105@root.org>
Date: Thu, 17 Mar 2005 12:34:02 -0800
From: Nate Lawson <nate@root.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] IDE failure on ACPI resume
References: <1110741241.8136.46.camel@tyrosine>  <423518E7.3030300@root.org> <1111072221.8136.171.camel@tyrosine>
In-Reply-To: <1111072221.8136.171.camel@tyrosine>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Sun, 2005-03-13 at 20:53 -0800, Nate Lawson wrote:
> 
> 
>>Sounds like PCI not being completely restored.  We had to work around 
>>some weird ATA issues in FreeBSD with the status register being invalid 
>>for quite a while after resume.  A retry loop was the solution.
> 
> 
> FreeBSD seems to fail in the same way on the same hardware,
> unfortunately. I'm leaning towards suspecting that we need to be doing
> something with the contents of the _GTF method, but by the looks of that
> that requires us to be able to work out which methods correspond to
> which hardware. Is anyone working on implementing this?
> 

Very interesting.  I was hoping to someday have _GTF et al implemented 
but the ATA knowledge required was above my head.  I also strongly 
suspected that the info published by _GTF would likely be invalid.  Does 
Windows actually use that method or just hardcoded ATA initialization?

-- 
Nate
