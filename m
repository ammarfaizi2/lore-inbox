Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUFLOmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUFLOmr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 10:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbUFLOmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 10:42:47 -0400
Received: from nepa.nlc.no ([195.159.31.6]:45757 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S264826AbUFLOmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 10:42:46 -0400
Message-ID: <1734.83.109.11.80.1087051353.squirrel@nepa.nlc.no>
In-Reply-To: <1087050351.707.5.camel@boxen>
References: <20040612134413.GA3396@sirius.home> 
     <1087050351.707.5.camel@boxen>
Date: Sat, 12 Jun 2004 16:42:33 +0200 (CEST)
Subject: Re: timer + fpu stuff locks up computer
From: stian@nixia.no
To: "Alexander Nyberg" <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org, "Sergey Vlasov" <vsu@altlinux.ru>,
       "Rik van Riel" <riel@redhat.com>
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry for this extremely informative mail but, doesn't work.
>
> Looks like the problem is only being delayed:

Makes sense, since fwait is done in kernel-mode and it takes some time for
the exception to rise, since this is a slow instruction. So the problem
gets delayed. What do you think Sergey?

Does the other dirty nasty patch work for you?


Stian Skjelstad
