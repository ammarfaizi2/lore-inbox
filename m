Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUFVNHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUFVNHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUFVNHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:07:52 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:22415 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262109AbUFVNHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:07:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Tue, 22 Jun 2004 08:07:47 -0500
User-Agent: KMail/1.6.2
Cc: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
References: <200406220953.01363.Marc.Waeckerlin@siemens.com>
In-Reply-To: <200406220953.01363.Marc.Waeckerlin@siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406220807.47328.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 June 2004 02:52 am, Marc Waeckerlin wrote:
> In May there was a posting Thorsten Hirsch and a patch reply by Dmitry 
> Torokhov that did not help Thorsten.
> 
> I have exactely the same problem, and other people too. There's a thread on 
> this topic with a more detailed problem description at:
> http://www.linuxquestions.org/questions/showthread.php?s=&postid=1004645#post1004645
> 
> The problem was pested regarding to Kernel 2.6.6, but an upgrade to Kernel 
> 2.6.7 did not help me. My problem is even much worse:
>  - The touchpad sometimes hangs and jumps.
>  - Hitting on the touchpad does no more click the first button.
>  - When I connect an external keyboard, the cursor somtimes jumps
>    around like crazy and clicks around like fool, even if I don't
>    click anything, but only move. When I then touch the keyboard,
>    the mouse becomes normal for a while - on SuSE kernel 2.6.5,
>    since. Since upgrade to kernel 2.6.7, does not become normal
>    any more.

Here your touchpad can be rest back to relative mode. Does passing
psmouse.resetafter=3 to the kernel helps things a bit?

-- 
Dmitry
