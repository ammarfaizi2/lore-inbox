Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbSBLQhE>; Tue, 12 Feb 2002 11:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288153AbSBLQgz>; Tue, 12 Feb 2002 11:36:55 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:9155 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S287676AbSBLQgl>; Tue, 12 Feb 2002 11:36:41 -0500
Subject: Re: nm256_audio.o
From: NyQuist <NyQuist@ntlworld.com>
To: Bruce Harada <bruce@ask.ne.jp>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020213011405.4f9f3c41.bruce@ask.ne.jp>
In-Reply-To: <1013529735.9204.23.camel@stinky.pussy> 
	<20020213011405.4f9f3c41.bruce@ask.ne.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 12 Feb 2002 16:31:59 +0000
Message-Id: <1013531519.9204.33.camel@stinky.pussy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-12 at 16:14, Bruce Harada wrote:
> On 12 Feb 2002 16:02:15 +0000
> NyQuist <NyQuist@ntlworld.com> wrote:
> 
> > Hi
> > I've a problem with this module. For some reason it locks up my laptop
> > when modprobed. I'm running redhat's 2.4.7-10 on an i686 and i'm using
> > the neomagic 256 chipset which I believe is a graphics/sound combination
> > (with 4 meg or so of mem), the comp is a dell latitude ls.
> > The card does work, as it runs under the commercial oss drivers, thing
> > is because the machine locks tight running the kernel 256_audio, I can't
> > get any debug information, the machine has to be physically
> > unplugged/debatteried (lucky I run ext3 :) Not even a messages error. 
> > Anyone with any info? I'm gonna have a look and try to debug, but i'm no
> > kernel hacker.
> 
> A vague memory of when I used to use a neomagic-based laptop tells me that you
> might want to try giving lilo (or whatever bootmanager you're using) a
> parameter to limit your memory to 1MB less than your actual memory... although
> this is from way back in 2.2.[789] days, I think. (For lilo, that would mean
> typing mem=xxxM or adding append="mem=xxxM" to /etc/lilo.conf, where xxx is
> your total RAM minus 1.)
Still not working, but thanks for the info anyway. Tried with 1,2 and a
couple of megs down from the physical memory from meminfo, but still no
dice. Afaik, i remember something about the memory of the graphics and
audio being shared, and since X cuts in first, it gobbles the memory up.
Not sure about that one as it still doesn't work if i run init3 and kill
X. 


