Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264405AbRFSQhA>; Tue, 19 Jun 2001 12:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264407AbRFSQgu>; Tue, 19 Jun 2001 12:36:50 -0400
Received: from AStrasbourg-201-2-1-133.abo.wanadoo.fr ([193.251.1.133]:58618
	"EHLO glacon.bureau.logidee.com") by vger.kernel.org with ESMTP
	id <S264405AbRFSQgb>; Tue, 19 Jun 2001 12:36:31 -0400
Date: Tue, 19 Jun 2001 18:36:02 +0200
To: Alexandr Andreev <andreev@niisi.msk.ru>
Cc: "David L. Parsley" <parsley@linuxjedi.org>, linux-kernel@vger.kernel.org
Subject: Re: Using cramfs as root filesystem on diskless machine
Message-ID: <20010619183602.N21063@logidee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3B2F7374.9000707@niisi.msk.ru>
User-Agent: Mutt/1.3.18i
From: Stephane Casset <sept@logidee.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jun 19, 2001 at 07:44:52PM +0400, Alexandr Andreev écrivait :
> David L. Parsley wrote
>
> Possibly, some symlinks are broken, or some libraries are missed, on my 
> rootfs...
> But it is very strange, that ext2fs ramdisk image works with the same 
> rootfs on it.
> I'll try to investigate it by myself.

I have almost the same problem, I am using a cramfs root filesystem, not a
ramdisk cramfs. When I use the very same content on ext2 mounted read-only
everything work as expected, but with cramfs some daemons don't start
(mingetty for example)... 

I mount tmpfs in /tmp and files touched in /var are symlinks to files in
/tmp... 

I don't have a clue of what goes wrong, hints a more than welcome ;)

linux is 2.4.5-ac15+patch for cramfs by Daniel Quinlan+Mathias
Killian (http://www.cs.helsinki.fi/linux/linux-kernel/2001-01/1064.html)

Regards,
Sept
-- 
Stéphane Casset           LOGIDÉE sàrl          Se faire plaisir d'apprendre
3, quai Kléber, Tour Sébastopol   Tel : +33 388 23 69 77  casset@logidee.com
F-67080 STRASBOURG Cedex 3        Fax : +33 388 23 70 00  http://logidee.com
