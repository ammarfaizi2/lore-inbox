Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVCSUvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVCSUvX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 15:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCSUvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 15:51:23 -0500
Received: from opersys.com ([64.40.108.71]:13580 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261775AbVCSUvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 15:51:20 -0500
Message-ID: <423C9361.4050308@opersys.com>
Date: Sat, 19 Mar 2005 16:02:25 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: karim@opersys.com
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Baruch Even <baruch@ev-en.org>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Relayfs question
References: <Pine.LNX.4.61.0503191852520.21324@yvahk01.tjqt.qr> <423C78E8.3040200@ev-en.org> <Pine.LNX.4.61.0503192014520.14144@yvahk01.tjqt.qr> <423C913B.6000307@opersys.com>
In-Reply-To: <423C913B.6000307@opersys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Karim Yaghmour wrote:
> What relayfs does, and does very well, is move very large amounts of
> data out of the kernel and make them available to user-space with very
> little overhead. In the actual case of your tty logger, I've browsed
> through the code briefly, and I think that with relayfs you should be
> able to:

Just to avoid any confusion, note that I'm referring mainly to rpldev.c,
which is the kernel-side driver for the logger, I haven't looked at any
of the user tools.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
