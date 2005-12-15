Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbVLOGrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVLOGrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVLOGrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:47:00 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:63811 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965154AbVLOGq7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:46:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RqN5r3xQ1zwyLcQEdxC8h+/pTT6qlsFz8bwimCSZkOWHMxn+GoIXd36pIgvuYvb2Yga4HaIQs2pxKI7WayFaBVbmbC9fdaRCviSDMdHkdHgZOXMR5wXPuqgDucRDqDzMPmSDjKX0c1q+JPFvjt/V6UKgjhaooQ1iR73P45pK5vE=
Message-ID: <47f5dce30512142246g53896be6t4aedfe7a133a04af@mail.gmail.com>
Date: Wed, 14 Dec 2005 22:46:58 -0800
From: jayakumar alsa <jayakumar.alsa@gmail.com>
To: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: cs5536 ID for cs5535audio
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <47f5dce30512142226n18fc4280m26ce5b0bb4b80d3f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200512141431.32685.rene@exactcode.de>
	 <47f5dce30512142226n18fc4280m26ce5b0bb4b80d3f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, jayakumar alsa <jayakumar.alsa@gmail.com> wrote:
> On 12/14/05, René Rebe <rene@exactcode.de> wrote:
> >  static struct pci_device_id snd_cs5535audio_ids[] = {
> > -	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO, PCI_ANY_ID,
> > -		PCI_ANY_ID, 0, 0, 0, },
> > +	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO,
> > +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> > +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
> > +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> >  	{}
> >  };

René,

Also, as Jiri suggested, could you change those to:

PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO)
PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO)

Thanks,
jk
