Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbRESNSw>; Sat, 19 May 2001 09:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261803AbRESNSc>; Sat, 19 May 2001 09:18:32 -0400
Received: from [206.11.178.253] ([206.11.178.253]:58119 "EHLO
	wind.enjellic.com") by vger.kernel.org with ESMTP
	id <S261800AbRESNSV>; Sat, 19 May 2001 09:18:21 -0400
Message-Id: <200105191318.f4JDICT08904@wind.enjellic.com>
From: greg@wind.enjellic.com (G.W. Wettstein)
Date: Sat, 19 May 2001 08:18:11 -0500
In-Reply-To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
       "Re: /dev/sch0 interface" (May 15,  6:35pm)
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/sch0 interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 15,  6:35pm, "Jeff V. Merkey" wrote:
} Subject: Re: /dev/sch0 interface

> On Tue, May 15, 2001 at 11:44:23PM +0000, Thorsten Kranzkowski wrote:
> > On Tue, May 15, 2001 at 03:08:01PM -0600, Jeff V. Merkey wrote:

> > > Is anyone actuaslly using the /dev/sch0 interface for SCSI tape changers
> > > in Linux?  I noticed that the device definitions are present, but I do not 
> > > see any driver shipped in the standard base that actually uses it.

> > http://www.in-berlin.de/User/kraxel/linux.html
> > 
> > works very well here (needs a minor #include to compile correctly, though)
> > 
> > I actually wonder why this isn't in the mainline kernel.

Just as a point of reference we are using this code to control a
couple of big StorageTek tape libraries (9710 and 9730).  It has
worked flawlessly.  It also supports reading the VOLID barcodes.

I would second the notion that it should go into the mainline sources
if the author is interested.  Very useful utility in big IT shops
doing serious backup.

> > > Thanks
> > > 
> > > Jeff

> > Thorsten

> Thanks.
> 
> Jeff

Best regards from North Dakota.

}-- End of excerpt from "Jeff V. Merkey"

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-4950            WWW: http://www.enjellic.com
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"MS can classify NT however they like.  Calling a pig a bird still
doesn't get you flying ham, however."
                                -- Steven N. Hirsch
