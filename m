Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270585AbTGYKPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 06:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272002AbTGYKPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 06:15:46 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:26015 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S270585AbTGYKPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 06:15:43 -0400
Message-ID: <0e0101c35297$cb1890f0$4fee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Clemens Schwaighofer" <cs@tequila.co.jp>
Cc: <linux-kernel@vger.kernel.org>
References: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60> <3F20E0ED.6010800@tequila.co.jp>
Subject: Re: Japanese keyboards broken in 2.6
Date: Fri, 25 Jul 2003 19:30:04 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Clemens Schwaighofer" <cs@tequila.co.jp> wrote:

> cheap, but working and I think it will stay so until 2.6 goes into final
> of distris:
>
> setkeycodes 0x6a 124 1>&2 in your rc.local, local.start or whatever.
> works fine for me for alle 2.5x kernels

There must be a ton of odd stuff going on.  "showkey" used to say that the
scan code is 0x7d not 0x6a, but now it displays weird stuff.  As previously
mentioned, "getkeycodes" displays a table which seems far removed from
reality.  But the patch from junkio@cox.net worked (but "showkey" and
"getkeycodes" still produce weird output).

-- Norman Diamond

