Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274549AbRJAEWF>; Mon, 1 Oct 2001 00:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274539AbRJAEVz>; Mon, 1 Oct 2001 00:21:55 -0400
Received: from codepoet.org ([166.70.14.212]:8822 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S274549AbRJAEVj>;
	Mon, 1 Oct 2001 00:21:39 -0400
Date: Sun, 30 Sep 2001 22:22:11 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
Message-ID: <20010930222210.A24037@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0109301819220.12896-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109301819220.12896-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.9-ac10-rmk1, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Sep 30, 2001 at 06:31:55PM -0400, Alexander Viro wrote:
> 
> 	One thing that doesn't work yet is support of Acorn partitions -
> I'm switching it to pagecache right now.

Well, acorn is broken anyways....  Try enabling in on a device
with native 2048 byte sectors and _no_ partition table will be
found on those devices (just an error msg resulting from acorn)

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
