Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTAVLKK>; Wed, 22 Jan 2003 06:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTAVLKJ>; Wed, 22 Jan 2003 06:10:09 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:44771 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S267425AbTAVLKI>; Wed, 22 Jan 2003 06:10:08 -0500
Date: Wed, 22 Jan 2003 12:19:05 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel param and KBUILD_MODNAME name-munging mess
Message-ID: <20030122111905.GD5239@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <200301201341.OAA23795@harpo.it.uu.se> <20030122105105.Z628@nightmaster.csn.tu-chemnitz.de> <15918.28753.632988.981832@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15918.28753.632988.981832@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson, Wed, Jan 22, 2003 11:20:01 +0100:
> Ingo Oeser writes:
>  > On Mon, Jan 20, 2003 at 02:41:03PM +0100, Mikael Pettersson wrote:
>  > > Booting kernel 2.5.59 with the "-s" kernel boot parameter
>  > > doesn't get you into single-user mode like it should.
>  > 
>  > Try using "s" instead. This works since ever. I didn't even know,
>  > that the other option exists, too.
> 
> That's a workaround for this particular case, but the name-munging
> is still wrong and broken.
> 
> With "foo-bar=fie-fum" passed to the kernel, "foo_bar=fie-fum" is
> what's put into init's environment. (I checked.)

 $ foo-bar=fie-fum
  bash: foo-bar=fie-fum: command not found

 $ foo_bar=fie-fum

I just mean to say, it is not exactly usual names one
get to see in an ordinary environment.

Still, i think you are right, it is somewhat unexpected.

-alex
