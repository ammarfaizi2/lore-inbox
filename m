Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273648AbRJEU62>; Fri, 5 Oct 2001 16:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRJEU6T>; Fri, 5 Oct 2001 16:58:19 -0400
Received: from ppp-RAS1-2-174.dialup.eol.ca ([64.56.225.174]:41220 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S273648AbRJEU6G>; Fri, 5 Oct 2001 16:58:06 -0400
Date: Fri, 5 Oct 2001 16:56:36 -0400
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: CPU Temperature?
Message-ID: <20011005165636.A1198@node0.opengeometry.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200110051951.f95JpTn00470@node0.opengeometry.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110051951.f95JpTn00470@node0.opengeometry.ca>; from MAILER-DAEMON@rambler.ru on Fri, Oct 05, 2001 at 03:51:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 02:43:24PM -0700, Dan Hollis wrote:
> > > How can I access the CPU temperature, fan speed etc. from Linux?
> > > Or is this too hardware dependent to implement a common interface?
>
> > lm-sensors - it works well. Its shipped in some vendor trees
> 
> Whats the schedule to merge with mainline kernel? Right now we have
> two i2c trees -- the one in the kernel and the one in lm-sensors...

On my Abit VP6, hardware monitoring is on IO address 0x294h to 0x297h.
Why do we have to patch kernel and load module?  Isn't there something
simpler which we can compile and run as root?

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
8 CPU cluster, Linux (Slackware), Python, LaTeX, Vim, Mutt, Tin
