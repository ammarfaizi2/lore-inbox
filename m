Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSBYVVJ>; Mon, 25 Feb 2002 16:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292275AbSBYVU6>; Mon, 25 Feb 2002 16:20:58 -0500
Received: from ns.suse.de ([213.95.15.193]:38923 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292229AbSBYVUp>;
	Mon, 25 Feb 2002 16:20:45 -0500
Date: Mon, 25 Feb 2002 22:20:43 +0100
From: Dave Jones <davej@suse.de>
To: Justin Piszcz <war@starband.net>
Cc: Daniel Quinlan <quinlan@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 - Fixed?
Message-ID: <20020225222043.B27081@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Justin Piszcz <war@starband.net>,
	Daniel Quinlan <quinlan@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0202251537080.31438-100000@freak.distro.conectiva> <Pine.LNX.4.21.0202251556140.31438-100000@freak.distro.conectiva> <6ypu2twaz3.fsf@sodium.transmeta.com> <3C7AA8F1.3F93EFB4@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7AA8F1.3F93EFB4@starband.net>; from war@starband.net on Mon, Feb 25, 2002 at 04:13:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 04:13:21PM -0500, Justin Piszcz wrote:
 > Looks like its fixed.
 > 
 > [root@war root]# cd /usr/src/linux-2.4.18
 > [root@war linux-2.4.18]# patch -p1 < ../linux-2.4.18
 > linux-2.4.18          linux-2.4.18.tar.bz2
 > [root@war linux-2.4.18]# patch -p1 < ../patch-2.4.18-rc4
 > patching file CREDITS
 > Reversed (or previously applied) patch detected!  Assume -R? [n]

 Only 1 chunk got dropped, not all of rc4.
 Check the rc4-final diff in testing/incr/ and apply with -R

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
