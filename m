Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSGXJUD>; Wed, 24 Jul 2002 05:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSGXJUD>; Wed, 24 Jul 2002 05:20:03 -0400
Received: from conductor.synapse.net ([199.84.54.18]:19979 "HELO
	conductor.synapse.net") by vger.kernel.org with SMTP
	id <S315468AbSGXJUC>; Wed, 24 Jul 2002 05:20:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: "D.A.M. Revok" <marvin@synapse.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Compile Bogons in 2.4.19-rc3 with Caldera OpenLinux 3.1's patched 2.95.2
Date: Wed, 24 Jul 2002 05:23:12 -0400
X-Mailer: KMail [version 1.3.1]
References: <20020724082557Z318273-685+17059@vger.kernel.org> <20020724090042Z315293-686+2972@vger.kernel.org> <20020724101620.A25115@flint.arm.linux.org.uk>
In-Reply-To: <20020724101620.A25115@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020724092002Z315468-685+17104@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I didn't know that. . .
  How's it supposed to know which version to include if there are 2 versions. 
. . hmmm . . . probably by specifying somesort of include-path that puts 'em 
in order-of-preference, then.

Thanks for setting me straight: stress is a bad caffeine-substitute, eh?
( actually, caffeine is an effective stress-substitute, methinks )

On Wed  24 July, 2002 05:16, you wrote:
> On Wed, Jul 24, 2002 at 05:03:52AM -0400, D. A. M. Revok wrote:
> > Oh, fucking great, /usr/include/asm /isn't/ a symlink to
> > /usr/src/linux/include/asm, it's its own directory.
>
> That's 100% correct.  /usr/include/asm and /usr/include/linux are supposed
> to be the kernel headers glibc was compiled with, not the kernel headers
> for the kernel you're trying to build.
