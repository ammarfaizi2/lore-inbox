Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTE0MFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTE0MFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:05:37 -0400
Received: from pop.gmx.net ([213.165.65.61]:32914 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263311AbTE0MFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:05:32 -0400
Message-ID: <3ED3579D.7030300@gmx.net>
Date: Tue, 27 May 2003 14:18:37 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Werner.Beck@Lidl.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in Kernel 2.4.21-rc1
References: <OF4CB12D76.81223041-ONC1256D33.0040CFEC-C1256D33.004202DC@eu.lidl.net>
In-Reply-To: <OF4CB12D76.81223041-ONC1256D33.0040CFEC-C1256D33.004202DC@eu.lidl.net>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner.Beck@Lidl.de wrote:
> Hello,
> I encountered a Kernel oops on two different PCs, both a configured
> identical. The system uses an ISDN connection to an Internet ISP and then
> establishes a VPN tunnel based on PPTP.
> As far as I can see in /var/log/messages the problem occurred on both
> system at the same time at 00:15, but not at the same day and not every

You are using SuSE 7.3, which leads me to the assumption that the
nightly cronjob at 00:15 is triggering this. One of the culprits I can
imagine is the updatedb run at that time. However, this is only
guesswork. The Oops itself does not give me any idea. Perhaps someone
else can help.

> day. No special program is running at that time. Basically it is a SuSE 7.3
> distribution, I made a Kernel upgrade.
> Hardware is a Fujitsu Siemens N300 PC with an IDE (7200 Rpm), Intel 845GI
> Motherboard, an ISDN PBX connected via USB to dial-up, the connection
> wasn't established when the system oopsed.
> Attached are some information.
> (See attached file: info.txt)(See attached file: oops.log)


HTH,
Carl-Daniel
-- 
http://www.hailfinger.org/

