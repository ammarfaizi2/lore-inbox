Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRKSVVh>; Mon, 19 Nov 2001 16:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280727AbRKSVV2>; Mon, 19 Nov 2001 16:21:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:7943 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280725AbRKSVVR>;
	Mon, 19 Nov 2001 16:21:17 -0500
Subject: Re: [bug report] System hang up with Speedtouch USB hotplug
From: Robert Love <rml@tech9.net>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Kilobug <kilobug@freesurf.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <E165lQB-0001DZ-00@baldrick>
In-Reply-To: <E165lQB-0001DZ-00@baldrick>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 19 Nov 2001 16:21:22 -0500
Message-Id: <1006204883.826.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-19 at 05:12, Duncan Sands wrote:
> Johan Verrept's driver has two parts: a kernel module and
> a user space management utility.  The kernel module is open
> source (GPL).  It has problems with SMP and preempt, but
> otherwise works well.

Anything that has problems with SMP is going to have problems with
preempt.  Further, most any module will need to be compiled as a
preemptible kernel version, just like you need SMP versions.

Binary modules just are always going to be a problem unless we
standardize more, and I'm not saying that is a good idea ...

	Robert Love

