Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVBXQDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVBXQDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVBXP7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:59:32 -0500
Received: from mivlgu.ru ([81.18.140.87]:22183 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S262422AbVBXPjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:39:20 -0500
Date: Thu, 24 Feb 2005 18:39:18 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: "M.Baris Demiray" <baris@labristeknoloji.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5
Message-Id: <20050224183918.3f9de18a.vsu@altlinux.ru>
In-Reply-To: <421DEB74.4060306@labristeknoloji.com>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	<20050224062908.GJ3163@waste.org>
	<421DCD44.1020504@tiscali.de>
	<1109255111.1452.6.camel@localhost.localdomain>
	<421DEB74.4060306@labristeknoloji.com>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005 16:57:56 +0200 M.Baris Demiray wrote:

> Steven Rostedt wrote:
> 
> > [...]
> > 
> > Anyone know if the linux-2.6.11-rc5.tar.bz2 has all the changes in it?
> > The tarball rc5 is smaller than rc4. Was there a lot taken out?
> 
> Take a look at the diffview of 2.6.11-rc4-rc5 incremental patch.
> 
> <snip>
> 5599 files changed, 166396 insertions(+), 293627 deletions(-)
> </snip>

And especially at this chunk:

--- linux-2.6.11-rc4/Makefile 2005-02-23 20:53:50.707759849 -0800
+++ linux-2.6.11-rc5/Makefile 2004-12-24 13:35:01.000000000 -0800
@@ -1,7 +1,7 @@
VERSION = 2
PATCHLEVEL = 6
-SUBLEVEL = 11
-EXTRAVERSION =-rc4
+SUBLEVEL = 10
+EXTRAVERSION =
NAME=Woozy Numbat
# *DOCUMENTATION*

Obviously 2.6.11-rc5 is screwed up.
