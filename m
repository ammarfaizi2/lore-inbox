Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWAWP0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWAWP0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWAWP0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:26:53 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:42933 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751475AbWAWP0w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:26:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=IupdQycm6I7ovHS+ljclQBDo17xy051pbkH/TmXLKFaWk2FjSv4kyerhBPI6adtpqagJaAOZwKPgEVNca5BIEv/H/3pVnyOltOSc0zwOtt+5ZvxFZK4yoFNrQUKDgFTexBKgD6i0mOB9zycbzbEfE406l+TbpBUDVzV92WIyRPg=
Date: Mon, 23 Jan 2006 16:26:24 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-Id: <20060123162624.5c5a1b94.diegocg@gmail.com>
In-Reply-To: <728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
References: <200601212108.41269.a1426z@gawab.com>
	<986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	<E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
	<728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 23 Jan 2006 09:05:41 -0600,
Ram Gupta <ram.gupta5@gmail.com> escribió:

> Linux also supports multiple swap files . But these are more

There're in fact a "dynamic swap" tool which apparently
does what mac os x do: http://dynswapd.sourceforge.net/

However, I doubt the approach is really useful. If you need that much
swap space, you're going well beyond the capabilities of the machine.
In fact, I bet that most of the cases of machines needing too much
memory will be because of bugs in the programs and OOM'ing would be
a better solution.
