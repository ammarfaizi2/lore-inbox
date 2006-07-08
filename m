Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWGHUYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWGHUYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWGHUYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:24:55 -0400
Received: from khc.piap.pl ([195.187.100.11]:44169 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030338AbWGHUYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:24:54 -0400
To: Avi Kivity <avi@argo.co.il>
Cc: Pavel Machek <pavel@ucw.cz>, Bill Davidsen <davidsen@tmr.com>,
       Benny Amorsen <benny+usenet@amorsen.dk>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <m364i8e42v.fsf@defiant.localdomain> <44AFFD61.1080407@argo.co.il>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 08 Jul 2006 22:24:51 +0200
In-Reply-To: <44AFFD61.1080407@argo.co.il> (Avi Kivity's message of "Sat, 08 Jul 2006 21:45:53 +0300")
Message-ID: <m34pxrj14c.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi@argo.co.il> writes:

>> What if the "undeleted" file contained /etc/shadow because someone
>> was changing password at the time? :-)
>>
>
> As the undeleter already had read access to the raw device,
> /etc/shadow was already compromised.

I understand only root had access, but the file in question might be
requested by a user. Of course root should have known the consequences
but...
-- 
Krzysztof Halasa
