Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262441AbRENT6N>; Mon, 14 May 2001 15:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbRENT6C>; Mon, 14 May 2001 15:58:02 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:64777 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262441AbRENT5y>;
	Mon, 14 May 2001 15:57:54 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105141957.f4EJvWJ42261@saturn.cs.uml.edu>
Subject: Re: Inodes
To: blessonpaul@usa.net (Blesson Paul)
Date: Mon, 14 May 2001 15:57:32 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010514065650.11112.qmail@nw176.netaddress.usa.net> from "Blesson Paul" at May 14, 2001 12:56:50 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blesson Paul writes:

> This is an another doubt related to VFS. I want to know
> wheather all files are assigned their inode number at the
> mounting time itself or inodes are assigned to files upon
> accessing only

That would depend on what type of filesystem you use.
For ext2, inode numbers are assigned at file creation.
For vfat, inode numbers are assigned as needed, and
forgotten when not needed.
