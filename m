Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281088AbRKKVda>; Sun, 11 Nov 2001 16:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281090AbRKKVdU>; Sun, 11 Nov 2001 16:33:20 -0500
Received: from AGrenoble-101-1-2-175.abo.wanadoo.fr ([193.253.227.175]:62614
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281088AbRKKVdD>; Sun, 11 Nov 2001 16:33:03 -0500
Message-ID: <3BEEEF1E.8050306@wanadoo.fr>
Date: Sun, 11 Nov 2001 22:35:26 +0100
From: =?ISO-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: joeja@mindspring.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: loop back broken in 2.2.14
In-Reply-To: <3BEEED3E.58867BFE@mindspring.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe wrote:

> compile 2.2.14.
> 
> Then
> 
> # modprobe -a loop
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol
> deactivate_page
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod
> /lib/modules/2.4.14/kernel/drivers/block/loop.o failed
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod loop failed
> 
> do recursive grep through kernel tree:
> 
> # rgrep -rl  deactivate_page *
> drivers/block/loop.c
> drivers/block/loop.o
> 
> Is there a fix for this?


yes, see 2.4.15pre1
warning, the iptables code in 2.4.15pre1 and pre2 seems broken.

François

