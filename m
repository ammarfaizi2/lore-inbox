Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282279AbRKWXMW>; Fri, 23 Nov 2001 18:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282280AbRKWXMM>; Fri, 23 Nov 2001 18:12:12 -0500
Received: from mail.cafes.net ([207.65.182.25]:18950 "HELO mail.cafes.net")
	by vger.kernel.org with SMTP id <S282279AbRKWXL7>;
	Fri, 23 Nov 2001 18:11:59 -0500
Date: Fri, 23 Nov 2001 17:11:57 -0600
From: Mike Eldridge <diz@cafes.net>
To: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesize limit on SMBFS
Message-ID: <20011123171157.Q21290@mail.cafes.net>
In-Reply-To: <Pine.LNX.4.42.0111231034330.15987-100000@boston.corp.fedex.com> <002801c1740f$7372f650$1300a8c0@marcelo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002801c1740f$7372f650$1300a8c0@marcelo>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 09:10:24AM -0200, Marcelo Borges Ribeiro wrote:
> I have fat32 partition, but the problem isn´t the size of partition it is
> 8GB. The problem is that if you want to
> create a cpio backup of a linux system 3.5GB (I did that to reformat a ext2
> to a reiserfs) to an available fat32 space, in my case the backup size is
> allways 2GB and when I tried to extract back I saw "unexpected end of file".
> So I thought it was that famous kernel limitation of 2GB under any kind of
> partition, but i was informed that fat has this limitation too. So the
> kernel may suport files bigger than 2GB (I really don´t know, I just know
> that in my case with fat32 it did not and I saw this too with some oracle
> databases that could not be used when they grow and reach 2GB, may be a
> library problem too).

ext2 has a 2GB filesize limitation.

-mike

--------------------------------------------------------------------------
   /~\  The ASCII                       all that is gold does not glitter
   \ /  Ribbon Campaign                 not all those who wander are lost
    X   Against HTML                          -- jrr tolkien
   / \  Email!

          radiusd+mysql: http://www.cafes.net/~diz/kiss-radiusd           
--------------------------------------------------------------------------
