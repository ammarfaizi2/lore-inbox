Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290084AbSBKSpj>; Mon, 11 Feb 2002 13:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290080AbSBKSpa>; Mon, 11 Feb 2002 13:45:30 -0500
Received: from ptldme-mls2.maine.rr.com ([24.93.159.133]:60303 "EHLO
	ptldme-mls2.maine.rr.com") by vger.kernel.org with ESMTP
	id <S290103AbSBKSp1>; Mon, 11 Feb 2002 13:45:27 -0500
Message-ID: <3C6811B7.D5E5A067@maine.rr.com>
Date: Mon, 11 Feb 2002 13:47:19 -0500
From: "David B. Stevens" <dsteven3@maine.rr.com>
Organization: Penguin Preservation Society
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
        Nathan <wfilardo@fuse.net>
Subject: Re: Mouse not working with linux-2.5.3-dj4
In-Reply-To: <3C647DBC.B0BE0EB@maine.rr.com> <3C65B40F.77DBE5EB@maine.rr.com> <20020210105338.A20425@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

I'll reconfigure X to use /dev/input/mouse and give it a spin, since
CONFIG_INPUT_MOUSEDEV is set to y.

Cheers,
  Dave

Vojtech Pavlik wrote:
> 
> On Sat, Feb 09, 2002 at 06:43:11PM -0500, David B. Stevens wrote:
> 
> > Dave,
> >
> > I have followed Vojtech Pavlik's advice and turned on I8042_DEBUG_IO the
> > result of which is attached.
> 
> The mouse looks like it operates just fine from the log. So it seems
> like you still have X or GPM configured to use /dev/psaux, instead of
> /dev/input/mice, and/or didn't enable CONFIG_INPUT_MOUSEDEV.
> 
> > Cheers,
> >   Dave
> >
> >
> >
> > "David B. Stevens" wrote:
> > >
> > > Dave,
> > >
> > > I have a Logitech radio control mouse that refuses to operate.  It is a
> > > PS/2 AUX device.  It appears that the mouse was properly detected
> > > according to the attached system log.  Do you see anything missing or
> > > incorrect in the attached config file?
> > >
> > > Thank you for any assistance that you can provide.
> > >
> > > Cheers,
> > >   Dave
> > >
