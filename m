Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132587AbRDKObt>; Wed, 11 Apr 2001 10:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132579AbRDKObk>; Wed, 11 Apr 2001 10:31:40 -0400
Received: from mx3out.umbc.edu ([130.85.253.53]:20668 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S132590AbRDKOba>;
	Wed, 11 Apr 2001 10:31:30 -0400
Date: Wed, 11 Apr 2001 10:31:28 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Marcin Kowalski <kowalski@datrix.co.za>
cc: <hahn@coffee.psychology.mcmaster.ca>, <tomlins@cam.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: memory usage - continued - iCache/Dentry cacheing bug???
In-Reply-To: <0104111623060I.25951@webman>
Message-ID: <Pine.SGI.4.31L.02.0104111030180.3516411-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001, Marcin Kowalski wrote:

> I then do a swapoff /dev/sda3 (250mb used), this completely locks the machine
> for 50 seconds and pushes the load to 31 when I can log back in. Then
> micraculously I am using only 170mb of physical ram. I turn swap back on and
> all is well....
> Can anyone please explain this odd behaviour.. ???
> Below is a free after this whole debacle..:::

another cute way of clearing memory is to do a:

dd if=/dev/hda of=/dev/null bs=<total memory> count=1


this will push some stuff into swap; but ...


