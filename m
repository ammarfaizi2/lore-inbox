Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQJ1Jcy>; Sat, 28 Oct 2000 05:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129280AbQJ1Jco>; Sat, 28 Oct 2000 05:32:44 -0400
Received: from james.kalifornia.com ([208.179.0.2]:42833 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129092AbQJ1Jc1>; Sat, 28 Oct 2000 05:32:27 -0400
Message-ID: <39FA9D27.838E9010@kalifornia.com>
Date: Sat, 28 Oct 2000 02:32:23 -0700
From: David Ford <david@kalifornia.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: pcmcia in test10pre6
In-Reply-To: <648.39f967c2.1f52d@trespassersw.daria.co.uk> <648.39f967c2.1f52d@trespassersw.daria.co.uk> <20001027105109.B5628@vger.timpanogas.org> <2e99.39f9d427.d8a80@trespassersw.daria.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Hudson wrote:

> In article <20001027105109.B5628@vger.timpanogas.org>,
>         "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> writes:
>
> JVM> Grab the pcmcia off sourceforge.  It seems to build and work.  The stuff
> JVM> in 2.4 at present is still somewhat broken.  I worked on this until 2:00
> JVM> last night getting it to build with 2.4.
>
> Couldn't get 3.1.21 to build (you using something later from CVS ?). [
> CONFIG_X86_L1_CACHE_SHIFT not defined in the right places].
>
> Droping the test5 modules/drivers into the pcmcia modules directory
> works fine.

10-6 includes and DH pcmcia simply don't get along, for some reason several of
the client drivers in the pcmcia package don't compile due to the above not
being defined.  I hacked it in for my copy simply because I needed it right then
and there.  I -don't- have an acceptable patch.  What I have is a gross
include-until-it-works.

-d

--
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
