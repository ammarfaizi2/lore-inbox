Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWIANWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWIANWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 09:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWIANWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 09:22:52 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:62620 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750864AbWIANWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 09:22:51 -0400
Date: Fri, 1 Sep 2006 15:19:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Richard Knutsson <ricknu-0@student.ltu.se>
cc: akpm@osdl.org, sfrench@samba.org, linux-cifs-client@lists.samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 1/2] fs/cifs: Converting into generic
 boolean
In-Reply-To: <44F83356.20207@student.ltu.se>
Message-ID: <Pine.LNX.4.61.0609011518030.21826@yvahk01.tjqt.qr>
References: <44F83356.20207@student.ltu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/fs/cifs/asn1.c	2006-09-01 01:24:45.000000000 +0200
> +++ b/fs/cifs/asn1.c	2006-09-01 02:43:09.000000000 +0200
> @@ -457,7 +457,7 @@ decode_negTokenInit(unsigned char *secur
> unsigned char *sequence_end;
> unsigned long *oid = NULL;
> unsigned int cls, con, tag, oidlen, rc;
> -	int use_ntlmssp = FALSE;
> +	int use_ntlmssp = false;

Should not this become 'bool use_ntlmssp'? Possibly in a later patch?


Jan Engelhardt
-- 
