Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278316AbRJSHXc>; Fri, 19 Oct 2001 03:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278320AbRJSHXX>; Fri, 19 Oct 2001 03:23:23 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:20886 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278316AbRJSHXG>; Fri, 19 Oct 2001 03:23:06 -0400
Date: 19 Oct 2001 09:16:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8B8fdgcmw-B@khms.westfalen.de>
In-Reply-To: <8658.1003375433@kao2.melbourne.sgi.com>
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <8658.1003375433@kao2.melbourne.sgi.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaos@ocs.com.au (Keith Owens)  wrote on 18.10.01 in <8658.1003375433@kao2.melbourne.sgi.com>:

> EXPORT_SYMBOL_GPL() allows for new interfaces to be marked as only
> available to modules with a GPL compatible license.  This is
> independent of the kernel tainting, but obviously takes advantage of
> MODULE_LICENSE() strings.

Incidentally, an argument can be made that using EXPORT_SYMBOL_GPL  
actually renders your code incompatible with the GPL, insofar as it  
violates the "additional restriction" clause. Which doesn't matter as long  
as it's *only* your code (author can always do different things), but  
*does* matter if you add *other* people's GPL code (such as the rest of  
the kernel), because it's *their* GPL that you're breaking ...

MfG Kai
