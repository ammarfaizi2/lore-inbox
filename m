Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbTEWHgV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTEWHgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:36:21 -0400
Received: from [62.29.100.73] ([62.29.100.73]:29315 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S263869AbTEWHgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:36:20 -0400
From: "ismail (cartman) donmez" <voidcartman@yahoo.com>
Organization: Bogazici University
To: Jeremy Buseman <naviathan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: scsi.h
Date: Fri, 23 May 2003 10:48:20 +0300
User-Agent: KMail/1.5.9
References: <20030522212820.81758.qmail@web41013.mail.yahoo.com>
In-Reply-To: <20030522212820.81758.qmail@web41013.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305231048.20559.voidcartman@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 May 2003 00:28, Jeremy Buseman wrote:
> Summary:  When compiling cdrtools with 2.5.69-bk13
> scsi.h causes errors at line 229 and 230.
>

Add

typedef unsigned char u8;

to scsihack.c under cdrtools source to the ifdef __LINUX__ part. This is a 
cdrtools bug not a kernel one.

Regards,
/ismail donmez

-- 
Microsoft Windows : Made for Internet
The Internet : Made For UniX
