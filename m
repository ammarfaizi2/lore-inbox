Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSLQAIN>; Mon, 16 Dec 2002 19:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSLQAIM>; Mon, 16 Dec 2002 19:08:12 -0500
Received: from urtica.linuxnews.pl ([217.67.200.130]:57615 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S261693AbSLQAHt>; Mon, 16 Dec 2002 19:07:49 -0500
Date: Tue, 17 Dec 2002 01:15:40 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: Alan Cox <alan@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.24-rc1
In-Reply-To: <200212162018.gBGKIdP18149@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0212170113350.14563-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Alan Cox wrote:

> Linux 2.2.24-rc1
[...]
> o	Fix misidentification of some AMD processors	(Bruce Robson)
[...]

Is it the following chunk? (I can't find anything more appropriate)
@@ -1378,7 +1378,8 @@
                        return;

                case X86_VENDOR_AMD:
-                       init_amd(c);
+                       if(init_amd(c))
+                               return;
                        return;

                case X86_VENDOR_CENTAUR:
What does it fix?

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

