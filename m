Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTEUUHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 16:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTEUUHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 16:07:16 -0400
Received: from minmail.no ([213.160.234.15]:50907 "EHLO new.minmail.no")
	by vger.kernel.org with ESMTP id S262177AbTEUUHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 16:07:15 -0400
From: Morten Helgesen <morten.helgesen@nextframe.net>
Reply-To: morten.helgesen@nextframe.net
Organization: Nextframe AS
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 734] New: compilation parse error in mwavedd.h before "wait_queue_head_t"
Date: Wed, 21 May 2003 22:20:17 +0200
User-Agent: KMail/1.5
References: <22830000.1053532326@[10.10.2.4]>
In-Reply-To: <22830000.1053532326@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305212220.17999.morten.helgesen@nextframe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 May 2003 17:52, Martin J. Bligh wrote:
>            Summary: compilation parse error in mwavedd.h before
>                     "wait_queue_head_t"
>     Kernel Version: 2.5.69
>             Status: NEW
>           Severity: normal
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: smart@smartpal.de
>
>
> Distribution:RedHat 8
> Hardware Environment:Dell Latitude C640
> Software Environment:Kernel only
> Problem Description:
>
> Steps to reproduce:
> Im not sure if the driver matches, but no matter...
>
> lspci: 00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02)
>
> CONFIG_MWAVE=m
>
> in the make modules phase, compilation of
> drivers/char/mwave/smapi.c:53 bails out in including
> drivers/char/mwave/mwavedd.h
> 129: prse err bfore "wait_queue_head_t"
> 140: prse err bfore "MWAVE_IPC"

IIRC this is fixed as of 2.5.69-bk3


-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
morten.helgesen@nextframe.net / 93445641
http://www.nextframe.net

