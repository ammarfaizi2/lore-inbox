Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSAVSRT>; Tue, 22 Jan 2002 13:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSAVSRK>; Tue, 22 Jan 2002 13:17:10 -0500
Received: from gate.in-addr.de ([212.8.193.158]:4876 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S287596AbSAVSQ7>;
	Tue, 22 Jan 2002 13:16:59 -0500
Date: Tue, 22 Jan 2002 19:18:19 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: metadata and contents in loop device
Message-ID: <20020122191819.Y916@marowsky-bree.de>
In-Reply-To: <20020122180201.42898.qmail@web14905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020122180201.42898.qmail@web14905.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-01-22T13:02:01,
   Michael Zhu <mylinuxk@yahoo.ca> said:

> Hello, everyone, in my loop device I want to use
> different keys to en/decrypt the file contents and the
> metadata of directories/file names information. But
> how can I differentiate these two types of data in the
> loop device? The loop device just cares about the
> block. But the metadata of directories/file names
> information is just the file system information. Any
> idea about this? Thanks in advance.

You can't.

Not without a special filesystem, which stored both kinds of data on different
block devices. Have fun writing one ;-)

What is the intended use of this?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

