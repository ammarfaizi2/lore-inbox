Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269544AbRGaXqT>; Tue, 31 Jul 2001 19:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269545AbRGaXqK>; Tue, 31 Jul 2001 19:46:10 -0400
Received: from weta.f00f.org ([203.167.249.89]:22158 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269544AbRGaXp5>;
	Tue, 31 Jul 2001 19:45:57 -0400
Date: Wed, 1 Aug 2001 11:46:35 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010801114635.C8839@weta.f00f.org>
In-Reply-To: <20010731032104.O2650@mea-ext.zmailer.org> <Pine.LNX.4.33L.0107302219340.5582-100000@duckman.distro.conectiva> <20010731232947.C13258@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010731232947.C13258@emma1.emma.line.org>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 11:29:47PM +0200, Matthias Andree wrote:

    If I understand SUS v2 correctly, fsync() must sync meta data
    corresponding to the file.

    If Linux ext2 doesn't to that, it might be a good idea to change
    that so it does.

Define 'meta-data' --- linux sync's any inode and/or bitmap changes,
fsyn on a file will ensure it is intact but not that it can't get
lost.



  --cw

