Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312608AbSDYCrV>; Wed, 24 Apr 2002 22:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312855AbSDYCrV>; Wed, 24 Apr 2002 22:47:21 -0400
Received: from ma-northadams1b-46.bur.adelphia.net ([24.52.166.46]:53382 "EHLO
	ma-northadams1b-46.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S312608AbSDYCrU>; Wed, 24 Apr 2002 22:47:20 -0400
Date: Wed, 24 Apr 2002 22:47:14 -0400
From: Eric Buddington <eric@ma-northadams1b-46.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: Dissociating process from bin's filesystem
Message-ID: <20020424224714.B19073@ma-northadams1b-46.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to dissociate a process from its on-disk binary?  In
other words, I want to start 'foo_daemon', then unmount the filesystem
it started from. It seems to me this would be reasonably accomplished
by loading the binary completely into memory first ro eliminate the
dependence.

Is this possible, or planned? Are there intractable problems with it
that I don't see?

Eric Buddington
