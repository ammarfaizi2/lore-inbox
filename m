Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312521AbSCYTuu>; Mon, 25 Mar 2002 14:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSCYTul>; Mon, 25 Mar 2002 14:50:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56334 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312521AbSCYTu2>; Mon, 25 Mar 2002 14:50:28 -0500
Date: Mon, 25 Mar 2002 14:47:56 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Grogan <grogan@pcnineoneone.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ANN: New NTFS driver (2.0.0/TNG) now finished.
In-Reply-To: <20020325121725.71f6df02.grogan@pcnineoneone.com>
Message-ID: <Pine.LNX.3.96.1020325144453.4219C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002, Grogan wrote:

> On a fresh boot with 2.4.19-pre4:
> 
> bash-2.05$ time cp -r /mnt/windows3/windows/system32 /home/grogan/test
> 
> real    8m45.256s
> user    0m0.730s
> sys     6m27.030s
> 
> On a fresh boot with 2.5.7 with the new NTFS driver:
> 
> bash-2.05$ time cp -r /mnt/windows3/windows/system32 /home/grogan/test
> 
> real    3m13.190s
> user    0m0.610s
> sys     0m51.660s
> 
> This "test" was repeated twice under the same conditions, with
> negligible difference in the result (couple of seconds). Both of these
> disks are on the same IDE controller (/home is /dev/hda8 and the NTFS
> partition is /dev/hdb2). I must say I wasn't expecting such a drastic
> difference. The data appears to be intact. (correct size and number of
> files, anyway) 

  Looks great, one of the few things in 2.5 I see as a reason upgrade in
the future. This could be really useful to people who need to pull NT
data.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

