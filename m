Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272270AbTGYT2D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272271AbTGYT2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:28:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48873 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272270AbTGYT15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:27:57 -0400
Date: Fri, 25 Jul 2003 16:39:29 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Marc Heckmann <mh@nadir.org>
Subject: Re: 2.4.22-pre5 deadlock
In-Reply-To: <01f001c352e4$9025e6d0$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307251638590.15120@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
 <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva>
 <008701c34a29$caabb0f0$3400a8c0@W2RZ8L4S02> <20030719172103.GA1971@x30.local>
 <018101c34f4d$430d5850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307210943160.25565@freak.distro.conectiva>
 <005a01c34fed$fea51120$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307220852470.10991@freak.distro.conectiva>
 <012d01c35066$2c56d400$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307221358440.23424@freak.distro.conectiva>
 <01f001c352e4$9025e6d0$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Jul 2003, Jim Gifford wrote:

> >From talking with others, we are considering this a netfilter issue, is this
> correct??

It seems you have isolated the problem down to additional netfilter
patches right ?
