Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVG1CET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVG1CET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 22:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVG1CET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 22:04:19 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:17350 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261243AbVG1CER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 22:04:17 -0400
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v850, which gcc and binutils version?
References: <42E78474.8070300@ppp0.net>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 28 Jul 2005 11:03:50 +0900
In-Reply-To: <42E78474.8070300@ppp0.net> (Jan Dittmer's message of "Wed, 27 Jul 2005 14:56:20 +0200")
Message-Id: <buo64uvit4p.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <jdittmer@ppp0.net> writes:
> Which is the recommended gcc/binutils combination for v850?

The most crucial thing is that all supported processors are v850e
derivatives (note the "e"), so please configure gcc/binutils for target
"v850e-elf".

[I usually use something bizarre and ancient, which appears to be a NEC
local derivative of gcc 2.9, but I've occasionally compiled the kernel
with gcc3 and it worked.]

-Miles
-- 
"1971 pickup truck; will trade for guns"
