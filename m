Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWAOQnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWAOQnL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 11:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWAOQnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 11:43:11 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:11229 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750708AbWAOQnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 11:43:09 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Console debugging wishlist was: Re: oops pauser.
To: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 15 Jan 2006 17:48:58 +0100
References: <5rvok-5Sr-1@gated-at.bofh.it> <5tagc-6AZ-25@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EyB3r-0000vP-G3@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:

> (it is hard to understand that with 128MB+ graphic cards and 512+MB
> computers the scroll back must be still so short...)

The VGA scrollback buffer is limited by the text area of the video RAM.
The text area is in the DOS memory at 0xB800 (or 0xB000) and extends
32 KB (or in case of MDA, 4 KB). Each character will use 2 Bytes.
Therefore you can store up to 16,000 characters or 4 pages of text.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
