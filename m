Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293520AbSCERIv>; Tue, 5 Mar 2002 12:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292898AbSCERIc>; Tue, 5 Mar 2002 12:08:32 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:1548 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292890AbSCERI1>;
	Tue, 5 Mar 2002 12:08:27 -0500
Date: Tue, 5 Mar 2002 09:00:47 -0800
From: Greg KH <greg@kroah.com>
To: Carl-Johan Kjellander <carljohan@kjellander.com>
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
Message-ID: <20020305170047.GA9388@kroah.com>
In-Reply-To: <3C8419FF.10103@kjellander.com> <20020305051146.GA7075@kroah.com> <200203051612.g25GCtc23752@fachschaft.cup.uni-muenchen.de> <3C84FAB4.7020702@kjellander.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C84FAB4.7020702@kjellander.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 05 Feb 2002 14:57:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 06:04:52PM +0100, Carl-Johan Kjellander wrote:
> Oliver Neukum wrote:
> >Am Dienstag, 5. März 2002 06:11 schrieb Greg KH:
> >
> >>On Tue, Mar 05, 2002 at 02:06:07AM +0100, Carl-Johan Kjellander wrote:
> >>
> >>>Attached to each one of these is an Philips ToUCam pro which uses the pwc
> >>>and pwcx modules. (yes, the kernel becomes tainted by the pwcx module)
> >>>
> >>As you are using this closed source module, I suggest you take this up
> >>with that module's author.
> >>
> >
> >Perhaps you could first ask whether the hang can be reproduced
> >without that module loaded ?
> >Secondly, that module is unlikely to cause that kind of trouble.
> 
> The problem can be reproduced on a computer that has not loaded pwcx.o
> after boot. The problem is not caused by pwcx.o at all.

But you are reading from the pwc driver, right?
Have you asked the author of that driver about this?

thanks,

greg k-h
