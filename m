Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130275AbRCFKGb>; Tue, 6 Mar 2001 05:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbRCFKGV>; Tue, 6 Mar 2001 05:06:21 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:34075 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S130274AbRCFKGF>;
	Tue, 6 Mar 2001 05:06:05 -0500
Message-ID: <3AA4B680.F9CAA01E@vz.cit.alcatel.fr>
Date: Tue, 06 Mar 2001 11:05:52 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 broke in-kernel ide_cs support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Arjan van de Ven (arjan@fenrus.demon.nl)
>Date: Mon Mar 05 2001 - 15:59:45 EST
>the module is called ide-cs.o and has been for a long time.....
That is the first error!
All pcmcia modules have the "_cs" suffix.
The change to "-cs" is the origin of many problems;
and it not the end !


>You must have lost your symlink :)
The symlink for ide*cs is not made by make module_install :-(

>It's better to change the /etc/pcmcia files to use ide-cs though, as that
>actually has a chance of working. (and works for me very well)
If I do that changes, I cannot boot with another old kernel;
config files must be compatible with all kernel versions.




