Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143371AbREKT4I>; Fri, 11 May 2001 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143372AbREKTz6>; Fri, 11 May 2001 15:55:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13069 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143371AbREKTzj>; Fri, 11 May 2001 15:55:39 -0400
Subject: Re: reiserfs, xfs, ext2, ext3
To: greg@linuxpower.cx (Gregory Maxwell)
Date: Fri, 11 May 2001 20:51:33 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010511153818.B19678@xi.linuxpower.cx> from "Gregory Maxwell" at May 11, 2001 03:38:18 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yIwn-0001ap-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does NFS server support for one of the included FSes not belong in the
> kernel?  or is it that a better way is possible and this ugly one should not
> be included?  If the latter, has anyone told Hans how to do it 'right' so he
> can assign someone to the task?

The patch Andi forwarded me for NFS still isnt too great but it meets the 
requirements in that it doesnt touch non reiserfs file systems and its fairly
easy to verify that the NFS code paths are not changed for other file systems

