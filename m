Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRE0VNA>; Sun, 27 May 2001 17:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbRE0VMv>; Sun, 27 May 2001 17:12:51 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:51518 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S262288AbRE0VMj>; Sun, 27 May 2001 17:12:39 -0400
Date: Mon, 28 May 2001 00:12:20 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: initrd oops [was Re: Linux 2.4.5-ac1]
Message-ID: <20010528001220.M11981@niksula.cs.hut.fi>
In-Reply-To: <20010526225825.A31713@lightning.swansea.linux.org.uk> <20010527192650.H11981@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010527192650.H11981@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Sun, May 27, 2001 at 07:26:50PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 07:26:50PM +0300, you [Ville Herva] claimed:
> On Sat, May 26, 2001 at 10:58:25PM +0100, you [Alan Cox] claimed:
> >
> > o	Free the initial ramdisk correctly
> 
> Who made this fix, or who can I contact? 
> 
> I have a reproducible oops on 2.4.4ac17 (see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=99079948404775&w=2 for
> details) that seems to be related:

Ok, some more info:                                                             
                                                                                
2.4.2-2 (redhat)       BOOTS OK                                                 
2.4.4ac17              OOPS                                                     
2.4.4ac17+av           OOPS                                                     
2.4.5                  OOPS                                                     
2.4.5ca1+av            OOPS                                                     
2.4.4                  BOOTS OK                                                 
2.4.4ac9               BOOTS OK                                                 
2.4.4ac10              BOOTS OK                                                 
2.4.4ac11              BOOTS OK                                                 
2.4.4ac12              fails to mount root ("Checking root filesystem.          
                                             /dev/sdb is mounted.")             
2.4.4ac14              fails to mount root                                      
2.4.4ac15              OOPS                                                     
                                                                                
This is:                                                                        
600Mhz Xeon                                                                     
256MB                                                                           
megaraid RAID and sym53c875 (from which I boot)                                 
gcc-2.96-85 (tried .91 as well)                                                 
                                                                                
                                                                                
So I gather the ac12 and ac15 Linux tree / av merges are the culprit?           


-- v --

v@iki.fi
