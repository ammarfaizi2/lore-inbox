Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbTGLSVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268198AbTGLSVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:21:14 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:22738 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S268160AbTGLSVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:21:12 -0400
Subject: Re: [PATCH] nbd.c compile warning
From: Shane Shrybman <shrybman@sympatico.ca>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Paul Clements <Paul.Clements@SteelEye.com>
In-Reply-To: <3F103FAD.4050506@aros.net>
References: <3F103FAD.4050506@aros.net>
Content-Type: text/plain
Organization: 
Message-Id: <1058034953.12636.28.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jul 2003 14:35:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-12 at 13:04, Lou Langholtz wrote:
> Do you have large block device support turned on or off in your kernel 
> build options? I believe this compile warning came as a result of 

# CONFIG_LBD is not set

> compiling without CONFIG_LBD - I hadn't tried building that way and 
> would then have missed this problem. Just typecasting the result as your 
> patch does should work correctly either way though. I'll make sure to 
> pull it into my NBD sources but you will need to get Andrew Morton or 
> Paul Clements to pick up the patch for it to move into the kernel distro 
> stream. I've CC'd them on this message to help expedite this. Thanks!
> 

Mr. Clements was cc'd on the original email as well. Thanks for looking
at the patch.

Regards,

shane

