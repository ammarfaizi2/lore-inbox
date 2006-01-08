Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWAHWKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWAHWKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWAHWKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:10:10 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:14856 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1161169AbWAHWKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:10:08 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] It's UTF-8
Date: Sun, 8 Jan 2006 22:10:09 +0000
User-Agent: KMail/1.9
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru> <Pine.LNX.4.61.0601082245090.17804@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601082245090.17804@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601082210.09536.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 January 2006 21:46, Jan Engelhardt wrote:
> >Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>
> I'd say ACK. However,
>
> > iocharset=name	Character set to use for converting from Unicode to
> > 		ASCII.  The default is to do no conversion.  Use
> >-		iocharset=utf8 for UTF8 translations.  This requires
> >+		iocharset=utf8 for UTF-8 translations.  This requires
> > 		CONFIG_NLS_UTF8 to be set in the kernel .config file.
>
> If you are really nitpicky about the "-", then it should also be
> "iocharset=utf-8" (and whereever else). Or what's the real purpose of
> adding the dashes in only half of the places, then?

Also what's "Unicode 16" as used in several places in the kernel. Surely this 
should be changed to UTF-16, which is the _encoding_ for the unicode 
character space.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
