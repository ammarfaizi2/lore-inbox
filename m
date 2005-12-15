Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVLOVmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVLOVmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVLOVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:42:50 -0500
Received: from amdext4.amd.com ([163.181.251.6]:40355 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751101AbVLOVmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:42:50 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Thu, 15 Dec 2005 14:44:32 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Andrew Morton" <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       info-linux@ldcmail.amd.com, "Jeff Garzik" <jgarzik@pobox.com>
Subject: Re: Geode LX HW RNG Support
Message-ID: <20051215214432.GB14013@cosmic.amd.com>
References: <20051215211248.GE11054@cosmic.amd.com>
 <20051215211423.GF11054@cosmic.amd.com>
 <20051215133917.3f0a5171.akpm@osdl.org>
MIME-Version: 1.0
In-Reply-To: <20051215133917.3f0a5171.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FBF3CC80C09480-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Should all the Geode additions to hw_random.c be inside __i386__, like VIA?

I thought that a early version did that and somebody took exception to 
it, but I can't find any e-mails to that effect right now.  Obviously, 
the defines are only useful when you have a Geode CPU (and thus a x86_32), 
so if nobody complains, I think that would be fine.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

