Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269515AbUINSMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269515AbUINSMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269662AbUINSJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:09:31 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:23210 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S269605AbUINR7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:59:23 -0400
Date: Tue, 14 Sep 2004 20:01:24 +0200
From: DervishD <lkml@dervishd.net>
To: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/config reducing kernel image size
Message-ID: <20040914180124.GA624@DervishD>
Mail-Followup-To: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>,
	linux-kernel@vger.kernel.org
References: <1095179606.11939.22.camel@host-81-191-110-70.bluecom.no> <20040914172646.GA614@DervishD> <1095183412.1834.7.camel@host-81-191-110-70.bluecom.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1095183412.1834.7.camel@host-81-191-110-70.bluecom.no>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-PopBeforeSMTPSenders: raul@dervishd.net
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Tom :)

 * Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no> dixit:
> > > There is no point in storing all the comments and unused options in the
> > > kernel image. This typically reduces the config size to about 1/5th
> > > before compressing, and to about 1/4th after compressing.
> >     I'm with you in that there is no point in storing the comments,
> > but I disagree about the unused options. Storing the unused options
> > as comments is more useful than it seems ;)
> This is why I added a config option.

    But removing the comments is a good idea. Even reformatting the
contents, or something like that.
 
> >     I'm not really sure about it, but I think that the unset options
> > are left as comments for the sake of automation. The space saving
> > doesn't (IMHO) worth the pain.
> I'm not sure either, but I don't know of any programs that uses this.

    Neither do I.

> Putting this config file inside the same source tree as it was compiled
> with, and then just starting and stopping menuconfig will restore it to
> it's original form.

    That's true.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
