Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUHUI0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUHUI0o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268898AbUHUI0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:26:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57577 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268899AbUHUI00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:26:26 -0400
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
From: Lee Revell <rlrevell@joe-job.com>
To: Josan Kadett <corporate@superonline.com>
Cc: "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <S268896AbUHUISZ/20040821081825Z+1927@vger.kernel.org>
References: <S268896AbUHUISZ/20040821081825Z+1927@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1093076785.854.54.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 04:26:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 05:18, Josan Kadett wrote:
> That is not much of an intelligible idea. A way to hack the kernel could be
> found as I still presume. "Turn off checksums" but not by re-writing the
> whole tcp code in the kernel. Isn't that possible ? Linux is an operating
> system of infinite possibilities, right ? But only if you know how to hack
> it...
> 

Can't you just go into the networking code, and find the part where it
checks the checksum, and just have it return success, even if the
checksum was bad?  Seems like a quick copy and paste hack.  Am I missing
something?

Lee


