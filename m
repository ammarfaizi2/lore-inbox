Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbWGNQK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWGNQK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbWGNQK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:10:58 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:64152 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161154AbWGNQK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:10:57 -0400
Message-ID: <44B7C37F.1050400@gentoo.org>
Date: Fri, 14 Jul 2006 17:17:03 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       greg@kroah.com, harmon@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org> <20060714154240.GA23480@tuatara.stupidest.org>
In-Reply-To: <20060714154240.GA23480@tuatara.stupidest.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> If someone who has this problem with ACPI is enabled can verify that
> Windows works that would be helpful, then we might be able to figure
> out why CONFIG_ACPI=y doesn't suffice for *some* people.  I've been
> told that VIA got their ACPI wrong in some cases so that might be why
> it doesn't work --- but if Windows deals with it we might be able to
> do whatever windows does in this case.

It is worth noting that on the Gentoo bug report, the user could not 
boot from VIA SATA while that ID was not in the list. However, if the 
ACPI was *disabled* then the system booted fine (even without the SATA 
ID in the list, i.e. no quirk applied).

This suggests that the quirk is only needed for ACPI users, at least on 
that system.

http://bugs.gentoo.org/show_bug.cgi?id=138036

Daniel

