Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTE0NJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 09:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTE0NJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 09:09:41 -0400
Received: from [62.159.241.4] ([62.159.241.4]:11528 "EHLO smtp.lidl.de")
	by vger.kernel.org with ESMTP id S263461AbTE0NJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 09:09:39 -0400
Subject: Antwort: Re: Oops in Kernel 2.4.21-rc1
To: c-d.hailfinger.kernel.2003@gmx.net
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OF8A85BDF9.FDFE6CE9-ONC1256D33.004946F5-C1256D33.00497FC6@eu.lidl.net>
From: Werner.Beck@Lidl.de
Date: Tue, 27 May 2003 15:22:48 +0200
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on LEUHQ0001MS6N/HUB/EU/LIDL(Release 5.0.10 |March 22, 2002) at
 27.05.2003 15:22:51,
	Itemize by SMTP Server on LEUHQ0001MS5N/LIDLEUEX(Release 5.0.10 |March 22, 2002) at
 27.05.2003 15:18:57,
	Serialize by Router on LEUHQ0001MS5N/LIDLEUEX(Release 5.0.10 |March 22, 2002) at
 27.05.2003 15:19:00,
	Serialize complete at 27.05.2003 15:19:00
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


could that be the process mandb and aaa_base which where affected by the
oops? How to disable this "feature"?


|---------+------------------------------------>
|         |           Carl-Daniel Hailfinger   |
|         |           <c-d.hailfinger.kernel.20|
|         |           03@gmx.net>              |
|         |                                    |
|         |           27.05.2003 14:18         |
|         |                                    |
|---------+------------------------------------>
  >------------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                              |
  |       An:       Werner.Beck@Lidl.de                                                                                          |
  |       Kopie:    linux-kernel@vger.kernel.org                                                                                 |
  |       Thema:    Re: Oops in Kernel 2.4.21-rc1                                                                                |
  >------------------------------------------------------------------------------------------------------------------------------|




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

> day. No special program is running at that time. Basically it is a SuSE
7.3
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






