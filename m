Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263524AbREYEk0>; Fri, 25 May 2001 00:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263528AbREYEkQ>; Fri, 25 May 2001 00:40:16 -0400
Received: from nwcst284.netaddress.usa.net ([204.68.23.29]:11154 "HELO
	nwcst284.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S263524AbREYEkJ> convert rfc822-to-8bit; Fri, 25 May 2001 00:40:09 -0400
Message-ID: <20010525044008.14212.qmail@nwcst284.netaddress.usa.net>
Date: 24 May 2001 22:40:08 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Re: How to add ntfs support]
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton
              So you are constructing a improved NTFS file driver. So when you
have to check your written codes of file driver, will u recompile the whole
kernel ? . That is what I am asking. I am in a way to build a new file system.
I took NTFS as a sample one. I thought , I will first try to compile and make
it run. 
Thanks in advance
                        by
                           Blesson Paul


Anton Altaparmakov <aia21@cam.ac.uk> wrote:
At 09:20 24/05/2001, Blesson Paul wrote:
>      I have redhat6.2. I have to add ntfs support to it(defaultly
>    it do not have). I know to do it by changing the configuration and
>    recompiling the whole kernel. I want to know , is there any method to
>register ntfs file system without recompiling the whole kernel

No, it is not possible to not recompile the kernel if NTFS was configured. 
You might see some very strange effects if you try... What is your problem? 
Just recompile the kernel. Remember NTFS should be used read-only as write 
support is broken.

I have a much improved NTFS driver but my Sourceforge linux-NTFS CVS is 
down (for a week now!) so I can't release it at the moment. )-:

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/



____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
