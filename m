Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287907AbSAHF2Y>; Tue, 8 Jan 2002 00:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287908AbSAHF2P>; Tue, 8 Jan 2002 00:28:15 -0500
Received: from cti06.citenet.net ([206.123.38.70]:8460 "EHLO cti06.citenet.net")
	by vger.kernel.org with ESMTP id <S287907AbSAHF2C>;
	Tue, 8 Jan 2002 00:28:02 -0500
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Mon, 7 Jan 2002 22:45:25 -0500
To: <linux-kernel@vger.kernel.org>
Subject: re: Whizzy New Feature: Paged segmented memory
X-mailer: tlmpmail 0.1
Message-ID: <20020107224525.8a899969dbcd@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002 14:14:30 -0500, Marcin Tustin wrote
>
> 	Any comments on how useful it would be to have paged, segmented,
> memory support for Pentium? I was thinking that by having separate
> segments for text, stack, and heap, buffer overrun exploits would be
> eliminated (I'm aware that this would require GCC patching as well).
> 	Obviously, I'm thinking that I (and any similar fools I could rope
> in) would try this (Probably delivering for a kernel at least a year out
> of date by the time we had a patch).

Another solution would be to have two stacks. One for variable (auto data)
and one for program execution (call). Beside cache effect, this would provide
mostly the same performance as we get now. Just wondering if someone had
toyed with this idea.


---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
