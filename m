Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265802AbRGODmd>; Sat, 14 Jul 2001 23:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265810AbRGODmX>; Sat, 14 Jul 2001 23:42:23 -0400
Received: from weta.f00f.org ([203.167.249.89]:42371 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265802AbRGODmP>;
	Sat, 14 Jul 2001 23:42:15 -0400
Date: Sun, 15 Jul 2001 15:42:19 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu, linux-mm@kvack.org
Subject: Re: RFC: Remove swap file support
Message-ID: <20010715154219.C7624@weta.f00f.org>
In-Reply-To: <3B472C06.78A9530C@mandrakesoft.com> <m1elrk3uxh.fsf@frodo.biederman.org> <20010715032528.E6722@weta.f00f.org> <m13d7z4dmv.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13d7z4dmv.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 11:35:52AM -0600, Eric W. Biederman wrote:

    I can't see how any device that doesn't support read or writing
    just a byte can be a character device.

For requests smaller than the natural block size, you buffer and throw
away... this will surely suck for writing do a hd byte-by-byte though
:)



  --cw
