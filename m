Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129146AbRBMX2O>; Tue, 13 Feb 2001 18:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129419AbRBMX2E>; Tue, 13 Feb 2001 18:28:04 -0500
Received: from unthought.net ([212.97.129.24]:34744 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S129146AbRBMX1w>;
	Tue, 13 Feb 2001 18:27:52 -0500
Date: Wed, 14 Feb 2001 00:27:50 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: Stale NFS handles on 2.4.1
Message-ID: <20010214002750.B11906@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

I'm running a compilation cluster with various machines now
on 2.4.1 all mounting the same home filesystem over NFS from
the central NFS server.

All machines are 2.4.1 using NFSv3, some SMP some UP.

NFS server is a dual running an SMP kernel

The NFS clients are getting
 "Stale NFS handle"
messages every once in a while which will make a "touch somefile.o"
fail.

It's quite annoying and I didn't see it on 2.2 even after the NFS
patches were integrated.

What happens is that one machine will finish compiling, and another
machine will immediately thereafter do a "touch some_output.o". This
"touch" sometimes fails with a stale handle message.

Is this a  known problem or should I submit more info ?  If so,
what info ?

(no nothing is overclocked, yes I'm using RedHat 7 kgcc)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
