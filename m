Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317360AbSGRIiP>; Thu, 18 Jul 2002 04:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317364AbSGRIiP>; Thu, 18 Jul 2002 04:38:15 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:54922 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317360AbSGRIiO>; Thu, 18 Jul 2002 04:38:14 -0400
Date: Thu, 18 Jul 2002 10:41:11 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Subject: Re: Breakage with "usb-storage: catch bad commands"
Message-ID: <20020718084111.GA2326@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
References: <20020716140722.GM7955@tahoe.alcove-fr> <20020716103503.B14269@one-eyed-alien.net> <20020717090554.GB14581@tahoe.alcove-fr> <20020717102939.A25228@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717102939.A25228@one-eyed-alien.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 10:29:39AM -0700, Matthew Dharm wrote:

> Hrm.. interesting.
> 
> It appears that when we probe for a device, we issue a proper INQUIRY.
> But, when we probe LUN != 0, we then send a bogus or semi-bogus INQUIRY.
> I'll have to look into this more.

Ok, I'll temporarly disable the BUG_ON() waiting for a fix.

Thanks.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
