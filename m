Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbUKLScc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbUKLScc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUKLScc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:32:32 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:36360 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262602AbUKLSca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:32:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WtT/tKjFm1PWN+zd4nIdywdCM2gm9kTxXkYqIY0kvclKTyhVpOgpz1Mi9c07Dkx5WlHjFrAYn0zJ3oHq1x36jhT06HtAD7hOMbnp59MgQKsZuS4hVWZyEqpZ1LgZwc2Dum1rVBeHTamsTAVjOP0gWB3yA0TY8c3WWazvpkfs07I=
Message-ID: <8ecd27430411121032756fbbd2@mail.gmail.com>
Date: Fri, 12 Nov 2004 13:32:29 -0500
From: Aristeu Sergio Rozanski Filho <aristeu.sergio@gmail.com>
Reply-To: Aristeu Sergio Rozanski Filho <aristeu.sergio@gmail.com>
To: Alexander Fieroch <fieroch@web.de>
Subject: Re: SNES gamepad doesn't work with kernel 2.6.x
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4194FF96.4030106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <cn044e$nnk$1@sea.gmane.org>
	 <8ecd274304111108404f3ecd2c@mail.gmail.com>
	 <cn0pvt$mcv$1@sea.gmane.org>
	 <8ecd27430411120227411e865f@mail.gmail.com> <4194FF96.4030106@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> # modprobe gamecon gamecon.map=0,1,0,0,0,0
> 
> or
> 
> # modprobe gamecon gc=0,1,0,0,0,0
> 
> I get "gamecon: Unknown parameter `gamecon.map'" in /var/log/syslog and
> dmesg.
maybe I'm wrong but the format foo.bar= is only used when it's
compiled as built-in, not as module

then, try do:
   modprobe gamecon map=0,1

it should work

-- 
Aristeu
