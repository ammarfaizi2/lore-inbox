Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130681AbQLCBGS>; Sat, 2 Dec 2000 20:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130767AbQLCBGI>; Sat, 2 Dec 2000 20:06:08 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25872 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130681AbQLCBGG>; Sat, 2 Dec 2000 20:06:06 -0500
Date: Sat, 2 Dec 2000 18:31:22 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, pavel@suse.cz,
        kernel@blackhole.compendium-tech.com, hps@tanstaafl.de,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Fasttrak100 questions...
Message-ID: <20001202183122.A21066@vger.timpanogas.org>
In-Reply-To: <E142GJB-0001kK-00@the-village.bc.nu> <200012022346.SAA17503@tsx-prime.MIT.EDU> <20001202182126.A20944@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001202182126.A20944@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Sat, Dec 02, 2000 at 06:21:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2000 at 06:21:26PM -0700, Jeff V. Merkey wrote:
> On Sat, Dec 02, 2000 at 06:46:59PM -0500, Theodore Y. Ts'o wrote:
> >    Date: 	Sat, 2 Dec 2000 17:18:43 +0000 (GMT)
> >    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > 
> > Well, it's not up to just me, given that Linus also has his copyright on
> > the code (although I doubt there's more than a few lines which are
> > originally his).  There are some other people who have contributed code
> > to the serial driver in the past, although most have probably not given
> > me more than a dozen lines of code or so, which seems to be the
> > (completely untested in court) standard which the FSF uses to decide
> > whether or not they need to get formal legal papers signed.  
> > 
> > The legal issues are also incredibly murky, 
> 
> that's "Merkey"
> 
> > since the customers create
> > the derived work, and issues of intent aside, you can't necessarily use
> > intent to change the legal definition of "derived work".  (Be glad;
> > although it can be used to create a loophole in GPL, just meditate a
> > while on what the MPAA could do with such an "intent" argument before
> > you decide whether or not it's a good thing.  Or think what Microsoft
> > could do if they could make their EULA's as infectious as the GPL with
> > the "intent" argument.)  The whole dynamic linking argument is a very
> > slippery slope; where do you draw the line?  Does a shell script which
> > calls a GPL program get infected?  What about a propietary C program
> > which makes a system() call to invoke a GPL'ed bash?  What about an RPC
> > call across the network?  What about a GNOME Corba interface?  Is it OK
> > if it's on separate machines, but are they considered a single program
> > if the CORBA client and server are on the same machine, since now they
> > share the same VM?


BTW, for those legal folks who also demand I post case law citations, please
see the Pesico vs. (I forget the guys name) case.  Just get on Westlaw, 
and look up "Pepsico".   This is the case where this doctrine was created 
and applied by a state judge.  The case was upheld, and has been used all 
over the US since then to shaft departing employees from big software/hardware 
companies.

Jeff


> 
> Under the "Doctrine of Inevitable Disclosure" even looking at GPL code
> and using techniques it contains would contaminate anything someone 
> works on.  This doctrine put forward two concepts that have been
> used in trade secret cases to justify injunctions and non-competes
> in areas of IP pollution -- negative knowledge and inevitable 
> misappropriation.
> 
> The argument goes something like this.  Negative knowledge is defined as 
> knowing what techniques do not work (as opposed to what techniques 
> do work).   In the course of development of a piece of software,
> there are many "blind alleys" and "false starts" that are encountered
> as an individual uses trial and error to perfect whatever piece 
> of software he is writing.  Over time, the person learns what 
> approaches are blind alleys and which work.  This knowledge becomes
> imprinted into the actual thinking processes of this person.  
> 
> Source code can also contain notes and comments about what does not
> work, and what does work.  Someone reading this source code would
> then incorporate these ideas and knowledge into their thinking 
> processes.  Companies spend lots of money paying engineers to 
> develop software, and this "negative knowledge", under the 
> doctrine of inevitable disclosure is legally the property 
> of an employer since they paid an engineer to experiment and 
> learn it.   This is how companies are able to get non-compete
> court orders against employees in trade secret lawsuits -- they 
> argue that noone is going to go down a development path using ideas 
> or approaches they know do not work.  This argument goes on 
> to state that if two engineers, one who had access to a piece of 
> code vs. one who did not were to start at the same time working 
> on the same problem, the person who had access to the code would
> finish first because he would "inevitably use" the knowledge gained
> from access to the source code.  
> 
> Let's say for example two engineers wanted to write a new Linux-like
> replacement.  One of them had access to ftp.kernel.org and the other
> did not.  Which one of the engineers would finish first?  Obviously
> the one with access to ftp.kernel.org would finish first and 
> would not have had to use trial and error to get all the IOCTL calls 
> working, etc.   The engineer without source code access would take 
> longer, perhaps by a factor of years, to complete the same project.
> 
> Under this argument, it is argued that the engineer who had source 
> code access "inevitably used" negative knowledge he gained from 
> his study of the Linux sources.  Absent the vague descriptions of
> what a "derivative work" is in the GPL, it could be argued that 
> conversion of any knowledge contained in GPL code is a "derivative
> work".  
> 
> There are a lot of big software companies who believe this and 
> fear application of the doctrine of inevitable disclosure relative
> to GPL code.  Novell and Microsoft both do not even allow employees 
> to bring GPL code into the building -- period -- for fear that someone
> will attempt to file a claim that they have "converted" GPL code 
> and created derivative works that may have contaminated non-GPL
> code projects.  Novell has an official standing policy barring employees
> from using GPL code.  That's why all the Linux work for NetWare is 
> done in the India development center, and not the US, out of fear 
> of IP pollution in the Provo facility.  When I officed at the Microsoft 
> campus in 1999, they had similiar policies, and were even more strict 
> than Novell.  
> 
> Now, in reality, these folks have employees in both companies who 
> download stuff at home, and putz around with it, GPL code included,
> but that's a lot different from these companies having official policies
> allowing projects to use GPL code in their normal course of business.
> 
> In short, under the doctrine of inevitable disclosure, a GPL copyright
> holder could succeed with a claim of conversion from someone simply 
> looking at a piece of GPL code, then using whatever it contained 
> to build either interface modules or a module with similiar functionality.
> It would be a hard call for a sitting judge to make, but I have seen 
> actual cases where a judge does just that with the help of a special 
> master.
> 
> Personally, I think the doctrine is one of the most evil fucking things
> in existence, legal opponents call it "the doctrine of intellectual
> slavery" because it has the affect under the law to be able to convert
> simple NDA agreements into non-compete agreements, and I've seen it 
> used this way.  Novell has blocked all internal access to the NWFS
> ftp server TRG, BTW, because they are afraid I would attempt to 
> apply the doctrine to force them to open source NetWare projects if 
> they download NWFS and used it internally with eDirectory.  They've
> told us so.  
> 
> This may help you understand just how complicated this whole IP stuff 
> is relative to derived works.  It's undefined under current case law
> and precednt relative to the GPL, but these big companies are taking 
> no chances....
> 
> :-)
> 
> Jeff
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
