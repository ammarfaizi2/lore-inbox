Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbULRT1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbULRT1R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 14:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbULRT1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 14:27:17 -0500
Received: from smtpout03-04.mesa1.secureserver.net ([64.202.165.74]:4289 "HELO
	smtpout03-04.mesa1.secureserver.net") by vger.kernel.org with SMTP
	id S261220AbULRT1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 14:27:15 -0500
Message-ID: <41C4849D.9060207@starnetworks.us>
Date: Sat, 18 Dec 2004 12:27:25 -0700
From: "Kevin P. Fleming" <kpfleming@starnetworks.us>
Organization: Star Networks, LLC
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
CC: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcapatch work for all bk transports
References: <Pine.GSO.4.44.0412181239400.2707-100000@sysperf.somerset.sps.mot.com>
In-Reply-To: <Pine.GSO.4.44.0412181239400.2707-100000@sysperf.somerset.sps.mot.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:

> I didn't even think if your case.  How about extracting out the transport
> from 'bk parent -p' as a middle ground.  I dont think this will help your
> case.  If not, we can leave the script as is.

It would actually be nice if bk supported a method to get the "root" 
parent path from any clone; this obviously won't work, though, if the 
clone is disconnected (on a laptop with no link, or something).
