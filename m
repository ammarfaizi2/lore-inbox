Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTJAOyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJAOyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:54:38 -0400
Received: from main.gmane.org ([80.91.224.249]:40614 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262259AbTJAOyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:54:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: [ACPI] p2b-ds blacklisted?
Date: Wed, 01 Oct 2003 16:53:40 +0200
Message-ID: <blepra$g94$1@sea.gmane.org>
References: <blen4v$a42$1@sea.gmane.org> <200310011516.45878.adq@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: de, en
In-Reply-To: <200310011516.45878.adq@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm sure I saw a comment somewhere saying the P2B-S was blacklisted because of 
> "bogus IRQ routing". It was in the blacklisting code, but I can't remember 
> where, or if it was 2.4 or 2.6.

Well, the P2B-S is in blacklist.c in 2.4.22.

What does the entry in blacklist.c mean? Does this entry mean acpi=ht is 
forced like the entry for the P2B-DS in dmi_scan.c?

Is this a hardwired problem on the Motherboard? Or might this be fixed 
with the latest BIOS?

I'd like to try ACPI on my P2B-DS anyway. I think there was an append 
line to disable ACPI IRQ Routing - was it acpi=pci?


