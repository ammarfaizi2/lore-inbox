Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWGGDrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWGGDrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWGGDrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:47:42 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:9649 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751172AbWGGDrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:47:41 -0400
Date: Thu, 6 Jul 2006 20:47:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Scott J. Harmon" <harmon@ksu.edu>, vsu@altlinux.ru,
       linux-kernel@vger.kernel.org
Subject: Re: acpi gets wrong interrupt for via sata in 2.6.16.17
Message-ID: <20060707034735.GA12908@tuatara.stupidest.org>
References: <449DE6BA.2050206@ksu.edu> <20060625132457.4b0922b4.vsu@altlinux.ru> <44A1C78C.4090401@ksu.edu> <44ADAB1F.6040208@ksu.edu> <20060706181453.3ce5a1c5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706181453.3ce5a1c5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 06:14:53PM -0700, Andrew Morton wrote:

> I have both reversion patches queued up but haven't heard from
> anyone about anything.

i saw that --- i don't think it's right, but it's not more wrong than
having that merged as-is in the first place which i'll argue is wrong
by virtue of the fact we run the quirk everywhere and apparently break
things

> I don't know if anyone's working on this bug.

it's not forgotten, i'm waiting to hear back from people still.
enabling ACPI *should* suffice, but for some people clearly it doesn't
(there are claims VIA got their ACPI wrong so this might explain why
it works for some people and not others)

> Thursday is my subsystem-maintainer-spamming day, so the reverts
> will be heading Gregwards today.

like i said, i really don't think reverting the patches is technically
correct, but given that i don't have adequate hardware to test against
it might be the least painful option right now

