Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316524AbSEUGFq>; Tue, 21 May 2002 02:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316525AbSEUGFp>; Tue, 21 May 2002 02:05:45 -0400
Received: from violet.setuza.cz ([194.149.118.97]:55312 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S316524AbSEUGFo>;
	Tue, 21 May 2002 02:05:44 -0400
Subject: Re: RFC - named loop devices...
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020521015517.609d5516.spyro@armlinux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 May 2002 08:05:44 +0200
Message-Id: <1021961145.260.0.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-21 at 02:55, Ian Molton wrote:
> I havent thought about this too much, but...
> 
> When /etc/mtab is a symlink to /proc/mounts the umount command will fail
> to unmount loopback mounted filesystems properly.
> 
> I was wondering if a solution to this would be to introduce 'named'
> loopback devices.
> 
> with named loop devices, umount will then know that mount was the
> creator of a loopback device that it mounted, and can safely destroy it.
> 
> at present, mounting and unmounting disc images causes one to run out of
> loopback devices rather rapidly.
> 
> If I were to knock up a patch to implement named loop devices, would it
> stand a chance of being accepted?
> 
> also, how should this work? should the name be that of the creating
> process or should it just be a field that the creator can fill in as it
> pleases?

What about losetup?

Regards
Frank

