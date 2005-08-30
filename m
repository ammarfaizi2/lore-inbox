Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVH3HA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVH3HA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 03:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVH3HA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 03:00:56 -0400
Received: from relay02.pair.com ([209.68.5.16]:17420 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751104AbVH3HA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 03:00:56 -0400
X-pair-Authenticated: 67.187.99.138
From: Chase Venters <chase.venters@clientec.com>
To: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: odd socket behavior
Date: Tue, 30 Aug 2005 02:01:12 -0500
User-Agent: KMail/1.8.1
References: <20050830065344.86508.qmail@web51807.mail.yahoo.com>
In-Reply-To: <20050830065344.86508.qmail@web51807.mail.yahoo.com>
Organization: Clientec, Inc.
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508300201.12413.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The socket is probably just lingering. Check the socket manual page in section 
7 (man 7 socket) for more information.

On Tuesday 30 August 2005 01:53 am, you wrote:
> Hello all,
>
> I am seeing something odd w/sockets.  I have an app
> that opens and closes network sockets.  When the app
> terminates it releases all fd (sockets) and exists,
> yet running netstat after the app terminates still
> shows the sockets as open!  Am I doing something wrong
> or is this something that is normal?
>
> TIA!
> Phy
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
