Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUJIVUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUJIVUj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUJIVUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:20:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:928 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267404AbUJIVUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:20:30 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xk6u0hw2m.fsf@mru.ath.cx>
References: <41677E4D.1030403@mvista.com>  <yw1xk6u0hw2m.fsf@mru.ath.cx>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1097356829.1363.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 17:20:30 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 09:15, Måns Rullgård wrote:
> I got this thing to build by adding a few EXPORT_SYMBOL, patch below.
> Now it seems to be running quite well.  I am, however, getting
> occasional "bad: scheduling while atomic!" messages, all alike:
> 

I am getting the same message.   Also, leaving all the default debug
options on, I got this debug output, but it did not coincide with the
"bad" messages.

Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)

Lee

