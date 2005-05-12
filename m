Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVELUp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVELUp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 16:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVELUp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 16:45:26 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:4072 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262106AbVELUpT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 16:45:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r+4MYI3RrM+/SCx1CRGLUAySwV8ry+JmJY8UUPL32/6x2WBZzS+OuaRDKpEKpdbS09WcbmWMKU+QBMwm4LD/7F4BfO6dfoTvJo8erOHVyHkrQKBM/c0tIr/+bDmxXjPpEEtbtV7MxElONACHDn9uFHuCexhvDjxN/mIrnFDMfPw=
Message-ID: <d120d50005051213453b9a0e6f@mail.gmail.com>
Date: Thu, 12 May 2005 15:45:19 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alan Bryan <icemanind@yahoo.com>
Subject: Re: Enhanced Keyboard Driver
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050512194805.52183.qmail@web53101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050512193917.GC8176@lug-owl.de>
	 <20050512194805.52183.qmail@web53101.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/05, Alan Bryan <icemanind@yahoo.com> wrote:
> >
> > What do you actually want to do?
> >
> specifically, I am trying to write a program similar
> to the old Sidekick program of the DOS days. A
> "daemon", if you will, that will popup on the screen
> when a predetermined series of keystrokes are hit. The
> program will then do various things, like record/play
> macros, calculator, calendar, programmer's guide, etc
> etc...
> 
> The part I'm having trouble with though is having it
> popup when predetermined keystrokes are pushed. I
> don't think Linux has a way to hook into the keyboard
> (if I'm wrong, someone please tell me).
> 

Well, I don't think you want to tap into the kernel driver for that. I
mean if one uses X over the network I would assume that the popup
driver will run on the remote box while keyboard is on my local box.

The daemon is for X environment, right? You need to work with X
server, not kernel.

-- 
Dmitry
