Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbTEaUpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 16:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTEaUpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 16:45:12 -0400
Received: from [62.29.80.118] ([62.29.80.118]:19329 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S264442AbTEaUpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 16:45:11 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: "Kevin P. Fleming" <kpfleming@cox.net>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
Date: Sat, 31 May 2003 23:58:03 +0300
User-Agent: KMail/1.5.9
Cc: LKML <linux-kernel@vger.kernel.org>
References: <3ED8D5E4.6030107@cox.net> <200305312325.07809.kde@myrealbox.com> <3ED91161.1050603@cox.net>
In-Reply-To: <3ED91161.1050603@cox.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305312358.03208.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 May 2003 23:32, Kevin P. Fleming wrote:
> See the beginning of my message... it only does so if _KERNEL_ is
> defined. Since other header files also directly include compiler.h even
> though they already include kernel.h, I didn't think this was an
> unreasonable solution (i.e. they must have done it for the same reason,
> since there are comments specifically about including compiler.h for
> "__user").
>

Thats a bigger problem and should be solved like  ( imho ) with higher level 
of kernel api which provides userspace apps kernel level operations.


Regards,
/ismail
