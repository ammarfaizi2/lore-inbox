Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVBWQk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVBWQk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 11:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVBWQk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 11:40:59 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:12913 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261497AbVBWQk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 11:40:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZKUuX4ENccsAIpnWPp06VWPOIrgw8YdN16u/8ku7ssBH5f34100a3ZvTV0LTa6aQzIgpwetLSsjuN/bjMaeDD2kGCHiPBVyXjSUS3ND0TepFhrmWW27gaWXFPSPcy2Cyd2t+ccvN52IdFarAk4O4/2P/j+F4zmwzmPbgldY0rEA=
Message-ID: <29495f1d05022308346e622d5e@mail.gmail.com>
Date: Wed, 23 Feb 2005 08:34:02 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Olaf Titz <olaf@bigred.inka.de>
Subject: Re: uninterruptible sleep lockups
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1D3hcW-0002h0-00@bigred.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <421A3414.2020508@nodivisions.com>
	 <E1D3hcW-0002h0-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 22:31:03 +0100, Olaf Titz <olaf@bigred.inka.de> wrote:
> In article <421A3414.2020508@nodivisions.com> you write:
> > The most recent one was yesterday: I had run lsusb in the morning and had no
> > problems, but at the end of the day I ran it again, and after outputting 3
> > lines of data, it hung, stuck in D-state.  So now I have this:
> >
> > [/home/user]$ ps aux|grep D
> > USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> > root        92  0.0  0.0     0    0 ?        D    Feb19   0:00 [khubd]
> > root       845  0.0  0.0     0    0 ?        D    Feb19   0:00 [knodemgrd_0]
> > root     29016  0.0  0.1  1512  592 ?        D    00:28   0:00 lsusb
> 
> I'm getting fairly repeatable deadlocks of this kind involving khubd
> with a USB storage device. Perhaps there's just a faulty locking issue
> in khubd.

Would you be willing to file a bugzilla (bugzilla.kernel.org) bug, if
it's still happening with 2.6.11-rc4? Or, if you have filed one,
please refer to it?

Thanks,
Nish
