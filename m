Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUBENyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUBENyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:54:31 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:970 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S265225AbUBENy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:54:29 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Date: Thu, 5 Feb 2004 13:57:03 +0000
User-Agent: KMail/1.6
References: <20040205014405.5a2cf529.akpm@osdl.org>
In-Reply-To: <20040205014405.5a2cf529.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402051357.04005.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 February 2004 09:44, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-m
>m1/
>
>
> - Merged some page reclaim fixes from Nick and Nikita.  These yield some
>   performance improvements in low memory and heavy paging situations.
>
> - Various random fixes.
>
>

Still doesn't boot on my nForce 2 system, hangs while probing PDC RAID card. 
Confirmed from 2.6.2-rc3-mm1 that it was likely related to ACPI changes, but 
reverting bk-acpi.patch makes no difference.

I'd like to test mainline, but I'm using gcc 3.4 snapshot, so I'll try later 
today with 2.6.2 + linus.patch.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
