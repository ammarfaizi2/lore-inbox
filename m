Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUDXUAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUDXUAc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 16:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDXUAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 16:00:32 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:63240 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S261913AbUDXUA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 16:00:27 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: standart events for hotkeys?
Date: Sat, 24 Apr 2004 22:00:22 +0200
User-Agent: KMail/1.6
References: <200404200042.24671.cijoml@volny.cz> <200404241918.22817.cijoml@volny.cz> <408AB7D6.4060305@hereintown.net>
In-Reply-To: <408AB7D6.4060305@hereintown.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404242200.22481.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 of April 2004 20:54, you wrote:
> Michal Semler wrote:
> > and this is what I mean. We should start project collecting this. As PCI
> > cards list for example.
>
> There are as many e-mail keys codes as there are e-mail programs.  And
> I'm sure there is over lap, where one keyboard's e-mail key, generates
> the same code as another's web browser key.  Also it doesn't really
> matter what a key is labeled, it could be assigned to anything.
>
> What there should be is a program that is configurable, that says when
> you see this key event, do this.  And such programs do exist, for
> example the GNOME desktop has ACME.
>
> All that has to be done is make sure the kernel passes this codes, and
> the user space program can gather them.  That seems to be working now.

Hi, 

this isn't true, coz when somebody (me) has two keyboards and both returns 
another scan codes for one labeled key, so you can't use hotkeys or Khotkeys 
or another one.

It is because when you pres e-mail key, in one keyboard it returns one 
scancode and run for example will run kmail, but when you press it on second 
keyboard and it returns another scancode, it runs and it will run xterm... :(

So we need wrapper which will translate scancodes from all keyboards to 
standart scancodes and then it can be used with hotkeys and will work with 
all keyboards and will start kmail everytime on every of keyboards.

Michal
