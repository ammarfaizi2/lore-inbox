Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbRFMKHa>; Wed, 13 Jun 2001 06:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262731AbRFMKHU>; Wed, 13 Jun 2001 06:07:20 -0400
Received: from mail.inup.com ([194.250.46.226]:518 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S262728AbRFMKHM>;
	Wed, 13 Jun 2001 06:07:12 -0400
Date: Wed, 13 Jun 2001 12:05:21 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Is this still the linux-kernel list?
Message-ID: <20010613120521.B30203@pc8.lineo.fr>
In-Reply-To: <Pine.LNX.4.33.0106122304440.26275-100000@dlang.diginsite.com> <20010613111640.C29895@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010613111640.C29895@pc8.lineo.fr>; from christophe.barbe@lineo.fr on Wed, Jun 13, 2001 at 11:16:40 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi great David;

Normally I would have just ignored your mail but one of your so great
points seems to fit with one of my recent post (perhaps you thought about
others) and I would like to give you my opinion about it.

On Wed, 13 Jun 2001 08:11:33 David Lang wrote:
> now we have the 'code from this company or anyone working there is not
> acceptable (now matter how well written) and may not even be looked at'
> 
> this sure doesn't seem like the same list that I have been reading for
> the
> last four years.
> 
> remember guys, it's supposed to be about the code. As long as the code is
> under an acceptable license who it's from or what it's going to touch
> isn't supposed to be the issue, the issue is supposed to be 'is this code
> an improvement (in performance, style, algorithm, etc combined)' if it is
> it makes it in.

I've recently send two mails about the isp2200 qlogic driver (qlogicfc)
included in the kernel. 

Two facts:

The qlogicfc driver in the kernel is outdated. Qlogic provides a newer one.
The main difference is that qlogic disable the IP support for an unknown
reason. The IP support is a usefull feature but the status of this driver
is IMHO "broken".
I think we should replace it by the newer from qlogic or remove it.
The only thing that the IP feature does it to influence customers to buy
the qlogic card for a feature which reveals to be not available when you
start using it. That's what I've done and I know that I'm not the only one.
It's interesting to know that this "IP over FC" feature is provided by
other cards.

>From a more general point of view. I fully disagree with your "only code
matters" approch. I strongly believe in the Free Software goal and It seems
to be the case of many linux kernel hackers. The kernel must IMHO be DFSG
compliant. 

Christophe

-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
