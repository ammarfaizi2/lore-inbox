Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933420AbWKNLgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933420AbWKNLgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933418AbWKNLgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:36:31 -0500
Received: from [212.33.185.17] ([212.33.185.17]:34688 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S933414AbWKNLga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:36:30 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: max heap usage of a Linux process
Date: Tue, 14 Nov 2006 14:39:38 +0300
User-Agent: KMail/1.5
References: <455873BA.1060908@Sun.COM> <4559619F.3090904@sun.com> <17753.41267.125633.668756@cerise.gclements.plus.com>
In-Reply-To: <17753.41267.125633.668756@cerise.gclements.plus.com>
Cc: linux-c-programming@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141439.38048.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glynn Clements wrote:
> Prasanta Sadhukhan wrote:
> > Actually, I have the process-pid(s) and I want to find out
> > programmatically, what's the max heap size that had been consumed by
> > that process at any given moment(based on user command) from another
> > process.
>
> Then you need to read the files in /proc/<pid>/*. There isn't a system
> call to get resource usage for another process.

Wow, really?  Reading /proc/<pid>/* is pretty expensive, especially if you 
have to do it for 1000's of procs.

That's probably why top is such a cpu-hog.


Thanks!

--
Al


