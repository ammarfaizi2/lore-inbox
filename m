Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274667AbRIYWor>; Tue, 25 Sep 2001 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274666AbRIYWoh>; Tue, 25 Sep 2001 18:44:37 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:24075 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274668AbRIYWoW>;
	Tue, 25 Sep 2001 18:44:22 -0400
Date: Tue, 25 Sep 2001 15:40:15 -0700
From: Greg KH <greg@kroah.com>
To: Mark Zealey <mark@itsolve.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010925154015.B15591@kroah.com>
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com> <20010925084439.B6396@us.ibm.com> <20010925200947.B7174@itsolve.co.uk> <20010925134232.A14715@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010925134232.A14715@kroah.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 01:42:32PM -0700, Greg KH wrote:
> On Tue, Sep 25, 2001 at 08:09:47PM +0100, Mark Zealey wrote:
> > On Tue, Sep 25, 2001 at 08:44:39AM -0700, Greg KH wrote:
> > 
> > > On Mon, Sep 24, 2001 at 12:40:44PM -0400, Arjan van de Ven wrote:
> > > > 
> > > > I'm composing a list of all existing binary only modules, 
> > > 
> > > Argus System's PitBull for Linux modifies the kernel.  No source or
> > > patches for these modifications can be found on the web, so I'm guessing
> > > that it's closed source:
> > > 	http://www.argus-systems.com/
> > 
> > Umm, is it me or is that totally against the GPL? Have you bitched at them about
> > this?
> 
> I have only talked to one of their resellers, who could not find a link
> to the code anywhere.  I have not asked them directly.  I will go do
> that right now.

Argus has responded to me that their kernel patch is released under the
GPL (and will be placing it up on a sf.net site soon.)  However their
security kernel module that their patch uses is closed source.  So add
them to the closed source module list :)

As for the legality of modifying the kernel to provide hooks for your
closed source driver, I'm not going to argue that one, but I thought it
was forbidden.

thanks,

greg k-h
