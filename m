Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270210AbTGRLOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271532AbTGRLOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:14:53 -0400
Received: from [213.229.38.66] ([213.229.38.66]:65216 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S270210AbTGRLOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:14:52 -0400
Message-ID: <3F17DA1E.5020506@winischhofer.net>
Date: Fri, 18 Jul 2003 13:29:34 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: What happened to SiS DRM?!@!
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
 > On Iau, 2003-07-17 at 17:40, nick@acolyte.merseine.nu wrote:
 > > in case my other message got buried.
 > >
 > > is there SiS DRM support in the 2.6.0 kernel ?
 >
 > SiS DRM hasn't been ported to XFree 4.3 as far as I know, nor yet S3
 > or VIA DRM.

Which is not really a good reason for why the SiS DRM module is still 
missing in 2.6...

The SiS _DRI_ driver has not been ported to Mesa 4 and later (which is 
why it is disabled in XFree 4.3), but for users of XFree 4.2 and 
earlier, the _DRM_ module could be of good use. (And at least on Debian, 
one could install the xlibsmesa3 packages over a 4.3 installation to get 
DRI working as before.)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



