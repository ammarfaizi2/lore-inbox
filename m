Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbRBQIT7>; Sat, 17 Feb 2001 03:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbRBQITt>; Sat, 17 Feb 2001 03:19:49 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:40196 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129453AbRBQITe>; Sat, 17 Feb 2001 03:19:34 -0500
Date: Sat, 17 Feb 2001 10:19:17 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org, zole@diamondhead.hesbynett.no
Subject: Re: 2.4.1-ac16 - Loopback device seems broken
Message-ID: <20010217101917.S1040@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010217082558.10830.qmail@diamondhead.hesbynett.no>; from zole@diamondhead.hesbynett.no on Sat, Feb 17, 2001 at 08:25:58AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2001 at 08:25:58AM -0000, you [Ole  André  Vadla  Ravnås ] claimed:                                                                       
> I don't know if this is broken in 2.4.1-ac17 and                              
> 2.4.2-pre4, but, what happens when mounting a filesystem                      
> using the loopback device is that the process 'dies' in some                  
> way and there's no way I can kill it.                                         
> This is what I did:                                                           
> mount /test-ext2-image.img /mnt/testimage -o loop,rw -t ext2                  
> And after that there's no way I can get the process killed...                 

Known problem.                                                                  
                                                                                
Go                                                                              
                                                                                
ftp://ftp.kernel.org/pub/linux/people/axboe                                     
                                                                                
and take the latest loop-? patch from there. Let Jens Axboe know if it works    
or if you still have problems. Particularry, if you can reliably reproduce      
the problem you referred.
                                                                                
I hear the patch should get merged to 2.4.1ac soon.                             

> Please CC replies to this email-address:                                      
> zole@diamondhead.hesbynett.no                                                 
> As I'm not currently subscribed to the linux kernel mailing-list. :-)         

And, your address zole@diamondhead.hesbynett.no does not work. I'm kinda
puzzled about how you expect people to reply you. With smoke signals?
                                                                               
> Ole AndréFå deg en gratis webmail fra Hesbynett!                              
> http://diamondhead.hesbynett.no                                               

Uh, yeah.
                                                                                
                                                                                
-- v --                                                                         
                                                                                
v@iki.fi                                                                        
