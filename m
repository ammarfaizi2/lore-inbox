Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVCWWbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVCWWbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVCWWbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:31:01 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55966 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262081AbVCWWau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:30:50 -0500
Subject: Re: ALSA bugs in list [was Re: 2.6.12-rc1-mm1]
From: Lee Revell <rlrevell@joe-job.com>
To: indrek.kruusa@tuleriit.ee
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <424074EB.9020904@tuleriit.ee>
References: <424074EB.9020904@tuleriit.ee>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 17:30:48 -0500
Message-Id: <1111617048.3377.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 21:41 +0200, Indrek Kruusa wrote:
> Lee Revell <rlrevell@xxxxxxxxxxx> wrote:
>  >
>  >/ On Mon, 2005-03-21 at 12:41 -0800, Andrew Morton wrote:/
>  >/ > From: bugme-daemon@xxxxxxxx/
>  >/ > Subject: [Bug 4282] ALSA driver in Linux 2.6.11 causes a kernel 
> panic when loading the EMU10K1 driver/
>  >/ > /
>  >/ /
>  >/ This one is a real mystery. No one can reproduce it./
> 
> Not quite true. This bug was current till today in Mandrake's kernel, 
> but with  2.6.11-5mdk they managed to get rid of it.
> The problem is not with loading the driver but when alsactl tries to 
> store/restore mixer settings.
> 

Please, make sure to use "reply to all" when replying to LKML mail.  I
easily could have missed this.

Do you have a link to the Mandrake bug report?  If other people have
been hitting this, they have not been updating the bug report:

http://bugme.osdl.org/show_bug.cgi?id=4282

> I have tried again with 2.6.12-rc1-mm1 and it is still there (for 
> example the Gnome won't start due to this).
> Below the oops part from messages.

Does it work if you just blow away the old mixer settings rather than
trying to restore them?

Anyway, this might be fixed in ALSA CVS.

Lee

