Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314156AbSDLXCz>; Fri, 12 Apr 2002 19:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314157AbSDLXCy>; Fri, 12 Apr 2002 19:02:54 -0400
Received: from firewall.ill.fr ([193.49.43.1]:61323 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S314156AbSDLXCx>;
	Fri, 12 Apr 2002 19:02:53 -0400
Date: Sat, 13 Apr 2002 01:02:29 +0200
From: Samuel Maftoul <maftoul@esrf.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: /dev/zero
Message-ID: <20020413010229.B11097@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 05:12:06PM +0200, Guillaume Gimenez wrote:
> Samuel Maftoul a écrit:
>     Samuel> It's just zeroes, so it allows you to test raw write speed on any
>     Samuel> device:
>     Samuel> dd if=/dev/zero of=/dev/hda to test your performances of hda ...
>     Samuel> normally if I get it well, /dev/zero can't be you're bottleneck.
>     Samuel>         Sam
oops really sorry, It will really earase your disk.
This morning I was really sleepy and wanted to write something other:
time dd if=/dev/zero of=/mnt/ bs=1024 count=100000 
and so you can know what's the speed not of your ide or scsi (or
something other) which is given by hdparm but it will give you the speed
through the used filesystem.
Sorry about that.
        Sam

> 
> Just to save Samuel's soul ;-)
> the dd command supplied above will erase your primary hard drive
> 
> To see hard drive performances, hdparm -tT /dev/hda is better.
> 
> PS: Pas sympa Samuel
> 
> -- 
> Guillaume Gimenez
