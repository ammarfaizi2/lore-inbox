Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTJSTja (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbTJSTja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:39:30 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:35266 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262110AbTJSTj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:39:28 -0400
Message-ID: <49794.192.168.9.10.1066592366.squirrel@ncircle.nullnet.fi>
In-Reply-To: <013801c39677$035e1d40$0514a8c0@HUSH>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>   
    <1066579176.7363.3.camel@milo.comcast.net><41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>
       <yw1x3cdpgm46.fsf@users.sourceforge.net>
    <48232.192.168.9.10.1066590873.squirrel@ncircle.nullnet.fi>
    <013801c39677$035e1d40$0514a8c0@HUSH>
Date: Sun, 19 Oct 2003 22:39:26 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Tomy,
>
> The
>
> hdparm -m0 device
>
> seems to have fixed the problem for me. I'll try increasing the number in
> the following days and run extensive tests, but for now, it's quite
> enough.

That is *very* interesting. I quess that's about the only hdparm
option that I have never tried before. I'm really interested in hearing
if that really fixes the problem for you and for good. The thing is
that the machine with HPT374-chip is running as a server so I'm
not very eager to use it as a test bed (unless it's absolutely necessary).
Please, if it's possible for you, try to copy say two big files from
one disk to another at the same time couple of times in order to see if
your machine is able to handle it ... I have been able to run mine
2-3 days in the past without any problems if there are _no_ major
disk transfers going on.

The question of course is why does that hdparm option seem to fix
the problem in this case ? Is it perhaps a bug in HPT374-driver or
some lower IDE-layer ? (Just quessing ...)

> BTW your email server doesn't seem to like my address and refuses to
> deliver
> any mail, if you aren't running it maybe you should tell the admin that
> he's
> blocking Spain's largest ISP for some reason?

I'm sorry, I don't accept mails coming from dsl/cable/modem-pools due to
high amount of spam. I will accept mails coming from your ISP's mail
gateway though.

Regards,
Tomi Orava


-- 
Tomi.Orava@ncircle.nullnet.fi
