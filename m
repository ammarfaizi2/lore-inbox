Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290930AbSBFXZs>; Wed, 6 Feb 2002 18:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290931AbSBFXZi>; Wed, 6 Feb 2002 18:25:38 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:3938 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290930AbSBFXZ0>; Wed, 6 Feb 2002 18:25:26 -0500
Date: Thu, 7 Feb 2002 00:30:51 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Warning, 2.5.3 eats filesystems
Message-ID: <20020206233051.GA503@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020205192826.GA112@elf.ucw.cz> <878za7wmg0.fsf@inanna.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878za7wmg0.fsf@inanna.rimspace.net>
User-Agent: Mutt/1.5.0-hc8-current-20020125i (Linux 2.4.18-pre8-rps i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Feb 06 2002, Daniel Pittman wrote:

> > 2.5.3 managed to damage my ext2 filesystem (few lost directories);
> > beware.

> I can confirm that there are filesystem corruption issues with 2.5.3;
> after this message I rebooted and did a forced fsck which turned up
> around a half dozen inodes where the block count in the inode itself was
> too high.

Exactly the same thing here, and I bet it _is_ 2.5.3 and not a relict from
a 2.5.3-pre patch because I switched directly from 2.4.17 to 2.5.3
without ever using any pre patch at this machine.

-- 
# Heinz Diehl, 68259 Mannheim, Germany
