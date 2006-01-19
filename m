Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161260AbWASQGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbWASQGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161280AbWASQGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:06:17 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:15368 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1161260AbWASQGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:06:17 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Courtier-Dutton <James@superbug.demon.co.uk>,
       Willy Tarreau <willy@w.ods.org>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: X killed
References: <43CA883B.2020504@superbug.demon.co.uk>
	<20060115192711.GO7142@w.ods.org>
	<43CCE5C8.7030605@superbug.demon.co.uk>
	<Pine.LNX.4.61.0601172111070.11929@yvahk01.tjqt.qr>
	<1137529025.19678.24.camel@mindpipe>
From: Nix <nix@esperi.org.uk>
X-Emacs: if it payed rent for disk space, you'd be rich.
Date: Thu, 19 Jan 2006 16:06:05 +0000
In-Reply-To: <1137529025.19678.24.camel@mindpipe> (Lee Revell's message of
 "17 Jan 2006 21:21:43 -0000")
Message-ID: <871wz4nqxe.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2006, Lee Revell wrote:
> The problem is, this python application is not supposed to kill 
> anything, so I think it is a bug in X, but I cannot find any way to 
> trace the fault. Even gdb says the application was killed, so exited 
> normally, and results in no back trace.
> 
> Is there any way in Linux to find out who did the "killing" ?"

It's probably easiest to build the X server with debugging and use the
two-machine procedure outlined in
<http://xorg.freedesktop.org/wiki/DebuggingTheXserver>.

(If you don't have two machines and two displays, debugging it gets
very much harder.)

-- 
`Logic and human nature don't seem to mix very well,
 unfortunately.' --- Velvet Wood
