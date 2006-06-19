Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWFSI5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWFSI5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWFSI5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:57:33 -0400
Received: from iona.labri.fr ([147.210.8.143]:61103 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1750701AbWFSI5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:57:32 -0400
Date: Mon, 19 Jun 2006 10:57:31 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060619085731.GH4253@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
References: <787b0d920606182047n62916655m5c88dc38e6b1ad72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <787b0d920606182047n62916655m5c88dc38e6b1ad72@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan, le Sun 18 Jun 2006 23:47:51 -0400, a écrit :
> Samuel Thibault writes:
> 
> >The attached patch sets such session and controlling tty up, which fixes
> >the issue. The unfortunate effect is that init might be killed if one
> >presses control-C very fast after its start.
> 
> Doesn't the kernel protect process 1 from any signal
> that it does not have a handler for?

Ah, yes, indeed, forgot that.

> I think there is no problem.

Agreed.

Samuel
