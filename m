Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313237AbSC2MVC>; Fri, 29 Mar 2002 07:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313238AbSC2MUx>; Fri, 29 Mar 2002 07:20:53 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:36228 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S313207AbSC2MUp>; Fri, 29 Mar 2002 07:20:45 -0500
Message-ID: <3CA45BEC.8030106@antefacto.com>
Date: Fri, 29 Mar 2002 12:19:56 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
In-Reply-To: <5.1.0.14.2.20020328200457.03dfda90@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a good default?

IMHO you usually would not want to execute stuff off NTFS, and
if you do you can always just explicitly invoke using wine like:
`wine /ntfs/lookout.exe`

To have all files executable breaks stuff like:
midnight commander (won't open executable files)
ls colorizing
shell tab completion
...

see:
http://marc.theaimsgroup.com/?t=100143416100009&r=1&w=2

I think the default should be
rx for directories and r for files

Padraig.

Anton Altaparmakov wrote:
> Hi,
> 
> NTFS 2.0.1 for kernel 2.5.7 is now available. This is a minor update, 
> mainly to allow binaries to be executed by changing the default 
> permissions on files to include the executable bit. This feature has 
> often been requested by wine users so here it is. (-:
> 
> Sorry for the quick succession of releases but the web server hosting 
> the 2.0.0 patches is now off line so I had to move the location and I 
> used the opportunity to release this minor update.
> 
> Best regards,
> 
>         Anton

