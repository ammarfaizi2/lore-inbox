Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293040AbSCEAQZ>; Mon, 4 Mar 2002 19:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293049AbSCEAQQ>; Mon, 4 Mar 2002 19:16:16 -0500
Received: from ns.suse.de ([213.95.15.193]:65298 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293040AbSCEAQJ>;
	Mon, 4 Mar 2002 19:16:09 -0500
Date: Tue, 5 Mar 2002 01:16:04 +0100
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: =?iso-8859-1?Q?Sebastian_Dr=F6ge?= <sebastian.droege@gmx.de>,
        linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [2.5.5-dj2] USB keyboard strangeness and ALSA error
Message-ID: <20020305011604.G23524@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>,
	=?iso-8859-1?Q?Sebastian_Dr=F6ge?= <sebastian.droege@gmx.de>,
	linux-kernel@vger.kernel.org, vojtech@suse.cz
In-Reply-To: <20020304211949.26f188ac.sebastian.droege@gmx.de> <20020304223530.GA5280@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020304223530.GA5280@kroah.com>; from greg@kroah.com on Mon, Mar 04, 2002 at 02:35:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 02:35:31PM -0800, Greg KH wrote:
 > > I've following problems with 2.5.5-dj2:
 > > If I try to enable numlock I get this message: hid-core.c: control queue full
 > > and the numlock LED doesn't shine but numlock is enabled
 > > This is on a USB keyboard (Cherry xyz... the one with included USB hub)
 > > While booting I get this message: hid-core.c: ctrl urb status -32 received
 > 
 > Can you please try 2.5.6-pre2 and let us know if you still have the USB
 > problem with that kernel?

 My money is on it being ok. -dj has vojtech's various new input layer
 trickery, which I'm suspecting is the real cause of the problem.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
