Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269087AbUHYBaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269087AbUHYBaa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269090AbUHYBaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:30:30 -0400
Received: from main.gmane.org ([80.91.224.249]:26255 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269087AbUHYBa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:30:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: fraga@abusar.org ( =?ISO-8859-1?Q?D=E2niel?= Fraga)
Subject: Re: Linux 2.6.9-rc1
Date: Tue, 24 Aug 2004 22:11:31 -0300
Organization: http://www.turbonerd.hpg.ig.com.br
Message-ID: <3j5tv1-ec2.ln1@tux.abusar.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
    <20040824184245.GE5414@waste.org>
    <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
    <cggjvs$bv9$1@sea.gmane.org> <412BDC86.8000608@sover.net>
Reply-To: fraga@abusar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200-207-206-233.dsl.telesp.net.br
X-Newsreader: knews 1.0c.0
X-Leafnode-Warning: administrator allowed illegal use of 8-bit data in header.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <412BDC86.8000608@sover.net>,
	Stephen Wille Padnos <spadnos@sover.net> writes:

> You wouldn't have to.  The patch method from 2.6.8.x to 2.6.8.x+1 would 
> be this:
> unpatch 2.6.8.x
> patch 2.6.8.x+1
> Actually, going from any patch sublevel to any other is the same two 
> steps: remove the last patch level, patch to the new level.

	Ok, I got it. So we have to do this:
    
1) If I have 2.6.8 and I want upgrade it to 2.6.8.1, I apply the
2.6.8.1 patch

2) If I have 2.6.8.1 and I want upgrade it to 2.6.8.2, I have to remove
2.6.8.1, so it can go back to 2.6.8 and I can apply the 2.6.8.2
directly on the 2.6.8 kernel. This is valid for any 2.6.8.x version for
instance...

3) Finally, if I have 2.6.8.x kernel and I want upgrade it to 2.6.9, I
can just remove the 2.6.8.x patch and apply 2.6.9 on 2.6.8 as I'm used
to do.

	Ok, it seems reasonable now. Thank you very much.

-- 
http://Processo.tk (1001 dias)
http://U-br.tk
Linux 2.6.7
São Paulo - SP

