Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132977AbRDEU66>; Thu, 5 Apr 2001 16:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbRDEU6s>; Thu, 5 Apr 2001 16:58:48 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52109 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132547AbRDEU6f>;
	Thu, 5 Apr 2001 16:58:35 -0400
Message-ID: <3ACCDC4F.242711DD@mandrakesoft.com>
Date: Thu, 05 Apr 2001 16:57:51 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Burns <sburns@wave3com.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Groups maximum
In-Reply-To: <50282217D047D411997400805FEAAA81B1AE12@mail.voicelink>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Burns wrote:
> 
> Hey all,
> 
> I have checked out the archives, and I found an old post regarding this.
> The solution in the post, however, did not work for me.  I am attempting to
> raise the maximum 32 group per user limit on my 2.4.2 kernel.  I patched
> both linux/include/linux/limits.h and the asm-i386/param.h, replacing the
> default "32" with "256."  My glibc is 2.1.2.  When I make clean, and
> recompile the kernel, it boots fine but I am still limited to 32 groups.  I
> don't need to do anything with glibc since it is of the 2.1 or greater
> category, correct?  Any ideas, hints, tricks?  Thanks a ton for your help,
> please CC me as I've not been approved yet as a member of this list.

You gotta change the task struct...

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
