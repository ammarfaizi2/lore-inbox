Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946138AbWBDAgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946138AbWBDAgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946139AbWBDAgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:36:00 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:49849 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946138AbWBDAf7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:35:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=j6RW51LA0dmS22NziBC6iott9i4kbXEtFphL8rYMiboLcyg4uzTfo7BfOcq96prilyrUDGubpTzWmuZpwrQfeDfR7IXIlrPzTfA00kMb1ROULQY79EqEe5t1q6QOqnQYTxi41u0O0Ficne8ysPKhHA4sOjrAzy1mq/KqNXtc7tw=
Date: Sat, 4 Feb 2006 01:35:22 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Ryan Anderson <ryan@michonline.com>
Cc: Larry.Finger@lwfinger.net, torvalds@osdl.org, ornati@fastwebnet.it,
       linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
Message-Id: <20060204013522.3656f4f6.diegocg@gmail.com>
In-Reply-To: <20060203235002.GA5580@mythryan2.michonline.com>
References: <43E39932.4000001@lwfinger.net>
	<Pine.LNX.4.64.0602031007420.4630@g5.osdl.org>
	<43E3A001.7080309@lwfinger.net>
	<20060203205716.7ed38386@localhost>
	<43E3BF5A.3040305@lwfinger.net>
	<Pine.LNX.4.64.0602031258300.4630@g5.osdl.org>
	<43E3C703.20501@lwfinger.net>
	<20060203235002.GA5580@mythryan2.michonline.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 3 Feb 2006 18:50:03 -0500,
Ryan Anderson <ryan@michonline.com> escribió:

> You may want to do a "git repack -a -d" to get everything condensed into
> a single pack file.  It will likely take a while to run, however.

diego@estel ~/kernel/linux-2.6 # git repack -a -d
Packing 185104 objects
Pack pack-b87f4fd87979fe91a0141c7037b3dfbddd0a8c0a created.
error: wrong index file size
diego@estel ~/kernel/linux-2.6 #

Is this expected? :/ (git 1.1.5)
