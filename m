Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264097AbRFFTUP>; Wed, 6 Jun 2001 15:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264104AbRFFTUF>; Wed, 6 Jun 2001 15:20:05 -0400
Received: from jalon.able.es ([212.97.163.2]:32718 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264097AbRFFTUB>;
	Wed, 6 Jun 2001 15:20:01 -0400
Date: Wed, 6 Jun 2001 21:19:54 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: john slee <indigoid@higherplane.net>
Cc: "David N . Welton" <davidw@apache.org>, linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
Message-ID: <20010606211954.E1565@werewolf.able.es>
In-Reply-To: <87snhdvln9.fsf@apache.org> <20010607000629.B3742@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010607000629.B3742@higherplane.net>; from indigoid@higherplane.net on Wed, Jun 06, 2001 at 16:06:29 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.06 john slee wrote:
> 
> On Wed, Jun 06, 2001 at 02:27:22PM +0200, David N. Welton wrote:
> > Perusing the kernel sources while investigating watchdog drivers, I
> > notice that in some places, Fahrenheit is used, and in some places,
> > Celsius.  It would seem logical to me to have a global config option,
> > so that you *know* that you talk devices either in F or C.
> 
> celsius is probably a sensible default - lots of the world uses it now.
> 

Problem is decimals and floating point... I suppose kernel people would
prefer whatever, but suited to get full intXX_t range, say ºC/10.
And if you do not want signs, centi-kelvin is the better choice:xxx.xx,
five digits, a short goes to 655-273=382 ºC-

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac9 #1 SMP Wed Jun 6 09:57:46 CEST 2001 i686
