Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVBFRzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVBFRzT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBFRzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:55:19 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:39039 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261257AbVBFRzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:55:04 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT] Better handling of bad xfers/interrupt delays in psmouse
Date: Sun, 6 Feb 2005 12:55:00 -0500
User-Agent: KMail/1.7.2
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <200502051448.57492.dtor_core@ameritech.net> <20050206092731.GA3869@elf.ucw.cz>
In-Reply-To: <20050206092731.GA3869@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502061255.00741.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 February 2005 04:27, Pavel Machek wrote:
> Hi!
> 
> > The patch below attempts to better handle situation when psmouse interrupt
> > is delayed for more than 0.5 sec by requesting a resend. This will allow
> > properly synchronize with the beginning of the packet as mouse is supposed
> > to resend entire package.
> 
> +                * This is second error in a row. If mouse was itialized - attempt
> +                * to rconnect, otherwise just signal failure.
> 
> Tooo many typso in on coment?
> 								Pavel

Sorry about that. If the patch turns out to be working fine I'll fix the
comments before resubmitting.

Hmm, wouldn't it be nice if they put spell checker in GCC? ;)

-- 
Dmitry
