Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314641AbSEUOMT>; Tue, 21 May 2002 10:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314637AbSEUOMS>; Tue, 21 May 2002 10:12:18 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:6666 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314634AbSEUOMO>; Tue, 21 May 2002 10:12:14 -0400
Message-Id: <200205211409.g4LE9HY31513@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC - named loop devices...
Date: Tue, 21 May 2002 17:11:34 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020521015517.609d5516.spyro@armlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 2002 22:55, Ian Molton wrote:
> I havent thought about this too much, but...
>
> When /etc/mtab is a symlink to /proc/mounts the umount command will fail
> to unmount loopback mounted filesystems properly.

I have such symlink!

> I was wondering if a solution to this would be to introduce 'named'
> loopback devices.
>
> with named loop devices, umount will then know that mount was the
> creator of a loopback device that it mounted, and can safely destroy it.
>
> at present, mounting and unmounting disc images causes one to run out of
> loopback devices rather rapidly.
>
> If I were to knock up a patch to implement named loop devices, would it
> stand a chance of being accepted?
>
> also, how should this work? should the name be that of the creating
> process or should it just be a field that the creator can fill in as it
> pleases?

Have no time to think about this now, but will test any patches -
I want /etc/mtab -> /proc/mounts to become standard practice
--
vda
