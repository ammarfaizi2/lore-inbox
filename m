Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSIALos>; Sun, 1 Sep 2002 07:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSIALos>; Sun, 1 Sep 2002 07:44:48 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:14989 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317017AbSIALor>; Sun, 1 Sep 2002 07:44:47 -0400
Subject: Re: SMB browser
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D709AB7.705@linkvest.com>
References: <3D709AB7.705@linkvest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 14:49:43 +0300
Message-Id: <1030880983.31921.47.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-31 at 13:30, Jean-Eric Cuendet wrote:
> Hi,
> I want to develop a filesystem driver. It will be able to access SMB 
> shares without mountnig.
> I'll do a daemon that use libsmbclient from Samba 3.0 that do all the 
> dirty stuff (getting the available domains, authenticating, getting 
> files, etc...) and a device driver that will be a filesystem driver. The 
> driver should communicate with the daemon to ask him about shares, 
> machines, domains, etc...

People who reinvent the wheel usually end up with a square one :-)

lufs is a User Land Filesystem for Linux - 
http://lufs.sourceforge.net/

Share && Enjoy,
Gilad.


-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

"Money talks, bullshit walks and GNU awks."
  -- Shachar "Sun" Shemesh, debt collector for the GNU/Yakuza

