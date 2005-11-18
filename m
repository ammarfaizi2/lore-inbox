Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbVKRLrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbVKRLrl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 06:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbVKRLrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 06:47:40 -0500
Received: from canardo.mork.no ([148.122.252.1]:10688 "EHLO canardo.mork.no")
	by vger.kernel.org with ESMTP id S1161077AbVKRLrk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 06:47:40 -0500
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>
To: Pavel Machek <pavel@ucw.cz>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Organization: m
References: <87zmoa0yv5.fsf@obelix.mork.no>
	<d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com>
	<20051118114032.GD15825@elf.ucw.cz>
Date: Fri, 18 Nov 2005 12:49:50 +0100
In-Reply-To: <20051118114032.GD15825@elf.ucw.cz> (Pavel Machek's message of
	"Fri, 18 Nov 2005 12:40:32 +0100")
Message-ID: <87psoytbtt.fsf@obelix.mork.no>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 * HZ?
>
> Funny, I thought that 6 seconds is way too much. Bjorn, please let us
> know if 30 seconds timeout helps.

It does.  


Bjørn
