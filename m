Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289138AbSBSBEe>; Mon, 18 Feb 2002 20:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289117AbSBSBEY>; Mon, 18 Feb 2002 20:04:24 -0500
Received: from sr1.terra.com.br ([200.176.3.16]:16078 "EHLO sr1.terra.com.br")
	by vger.kernel.org with ESMTP id <S289115AbSBSBEO>;
	Mon, 18 Feb 2002 20:04:14 -0500
Date: Mon, 18 Feb 2002 21:39:17 -0300
From: Gustavo Noronha Silva <kov@debian.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gnome-terminal acts funny in recent 2.5 series
Message-Id: <20020218213917.60e4dd5c.kov@debian.org>
In-Reply-To: <3C719641.3040604@oracle.com>
In-Reply-To: <3C719641.3040604@oracle.com>
Organization: Debian-BR
X-Mailer: Sylpheed version 0.7.1claws12 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: Debian GNU/Linux SID
X-Face: BUFAba1BC<T<>{/6^&XIbU0Ja-yvA>@_Aq,6x\\v4P|cLoc|[OA)cTjqB4<l3e_~P<1"De[ V9(^p$M9?\H#o13H!u&Ql-@@tc\6CtR`qw~-JLOW}vR^|t6EKEb.7JcLW1)#(/d(psSss+.StN-7j& !,6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002 01:03:13 +0100
Alessandro Suardi <alessandro.suardi@oracle.com> wrote:

> Running Ximian-latest for rh72/i386, latest 2.5 kernels (including
>   2.5.4-pre2, 2.5.4, 2.5.5-pre1).
> 
> Symptom:
>    - clicking on the panel icon for gnome-terminal shows a flicker
>       of the terminal window coming up then the window disappears.
>      No leftover processes.
> 
> What works 100%:
>    - regular xterm in 2.5.x
>    - gnome-terminal in 2.4.x (x in .17, .18-pre9, .18-rc2)
I noticed this problem also... it seems the problem lies on
devpts, I enabled it on my 2.5.5pre1 build, mounting
devpts with the options given on the "readme" file
made gnome-terminal start on the second try, almost
everytime

[]s!

-- 
    Gustavo Noronha Silva - kov <http://www.metainfo.org/kov>
*---------* -+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+-+
|  .''`.  | Debian GNU/Linux: <http://www.debian.org>         |
| : :'  : + Debian BR.......: <http://debian-br.cipsga.org.br>+
| `. `'`  + Q: "Why did the chicken cross the road?"          +
|   `-    | A: "Upstream's decision." -- hmh                  |
*---------* -+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+-+
