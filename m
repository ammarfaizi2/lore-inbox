Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbTA3Rll>; Thu, 30 Jan 2003 12:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTA3Rll>; Thu, 30 Jan 2003 12:41:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26248
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267571AbTA3Rlk>; Thu, 30 Jan 2003 12:41:40 -0500
Subject: Re: [PATCH] 2.5.59 morse code panics
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Tomas Szepe <szepe@pinerecords.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Rodland <arodland@noln.com>, john@grabjohn.com
In-Reply-To: <20030130173642.GB25824@codemonkey.org.uk>
References: <20030130150709.GC701@louise.pinerecords.com>
	 <20030130173642.GB25824@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043952334.31674.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 18:45:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 17:36, Dave Jones wrote:
> As this patch further builds upon the previous one,
> It'd take a complete change of mind on his part to take
> this as it is.

If its attached to atkbd then its not a PCism and its now
nicely modularised in the atkbd driver. Providing we have
a clear split between the core "morse sender" and the
platform specific morse output device (do we want 
morse_ops 8)) it should be clean and you can write morse
drivers for pc speaker, for non pc keyboard and even for
soundblaster 8)

