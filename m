Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVJFLhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVJFLhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 07:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVJFLha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 07:37:30 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:19685 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750807AbVJFLha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 07:37:30 -0400
Message-ID: <43450CE5.50302@aitel.hist.no>
Date: Thu, 06 Oct 2005 13:39:17 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Emmanuel Fleury <fleury@cs.aau.dk>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: freebox possible GPL violation
References: <20051005111329.GA31087@linux.ensimag.fr> <4343B779.8030200@cs.aau.dk> <1128511676.2920.19.camel@laptopd505.fenrus.org> <4343BB04.7090204@cs.aau.dk> <1128513584.2920.23.camel@laptopd505.fenrus.org> <4343C0DB.9080506@cs.aau.dk> <1128514062.2920.27.camel@laptopd505.fenrus.org> <4343C73E.9000507@cs.aau.dk> <20051006000741.GC18080@aitel.hist.no> <Pine.LNX.4.62.0510051741310.14560@qynat.qvtvafvgr.pbz> <4344EC64.2010400@aitel.hist.no> <4344F39B.10806@cs.aau.dk>
In-Reply-To: <4344F39B.10806@cs.aau.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Fleury wrote:

>Helge Hafting wrote:
>  
>
>>Interesting argument, but it breaks for at least two reasons: 1. You
>>can buy that box instead of just hiring it. That moves kernels 
>>"outside the company", for money even.
>>    
>>
>
>I might have misunderstood but I think that if you buy the hardware you
>cannot connect it to the DSLAM network anymore. So that only the boxes
>they own are connected to the DSLAM.
>  
>
Well, but there still is a kernel in the box that was downloaded before
they bought it?  Or does the box become unuseable when they buy it?

>  
>
>>2. It doesn't matter if they only move kernels withing their own 
>>companys equipment. If they lend a customer equipment containing a
>>linux kernel, then they're lending them a linux kernel.  Lending is
>>distribution!
>>    
>>
>
>Are you sure this point has been clarified in court in the past ?
>If not, I would bet on it (for the specific case of settop boxes).
>  
>
Licencing rules applies when copying stuff for internal use.
Consider what would happen, if the company used windows
instead of linux on their boxes:
Everytime they copy windows onto a box they have to pay ms for another
licence.  Big companies can't jsut buy a single windows licence and
copy it to all their desktops.  BSA has definitely clarified that in court.
Now, the ms licence specifies payments to ms.  The GPL is just another 
licence,
with slightly different terms.  Instead of a payment, it specifies source
availability as the "price". 

There is clearly court precedent that companies have to comply with 
software
licences when making copies for _internal_ use.  GNUs licence or ms licence
shouldn't matter.

>"internal use" is kind of a buzz word here and should probably be
>clarified for this kind of cases.
>
>For now, I really don't see the flaw in Free's argument.
>  
>
If "when do we invoke the GPL" is hard to see, try considering
"when do we have to pay" if using ordinary proprietary pay-per-instance
software.  You will then find that the cases are similiar.

If the company makes and distributes an internal copy of windows, then 
they pay ms.
If the company makes and distributes an internal copy of linux, then 
they have to
provide an internal copy of the source as well.

If I make a business out of lending windows boxes, then I have to pay 
licences
on each box.  If I lend customers linux boxes, I should lend them the 
source too if they
requests it.  Remember, even if the average customer doesn't know what 
software
is in the box, they still have the right to make a copy of the linux 
kernel, because you
cannot take away that right.

>I mentioned in another mail the case of a mobile phone network
>infrastructure where the network nodes to which mobile phones are
>connecting are running Linux. It seems to be an "internal use" (as it
>never leak out of the company network) and yet providing a service to
>customers.
>  
>
This is fine.  Similiar to how I can run a linux-based webserver, without
having to provide people with linux source.  This because I don't give
them the server that contains linux.  But if you _sell_ one of those
network nodes, then you have to provide linux source along with it.

>The only difference in the Freeboxes case is that the node is at the
>customer place (you can compare the customer's mobile phone to the
>customer's computer plugged on the Freebox). But the fact that you don't
>share your node with others and that you have it at home doesn't change
>the fact that the company own it.
>  
>
Interesting argument indeed.  But consider: what would happen
if the phones (or freebox) were to run windows?  The distributing
company would have to pay licencing fees, right? 

>Has been any previous similar cases in the past which went in court ?
>
>  
>
There have at least been cases where companies were selling
linux-powered products, and were told that they had to
provide the sources.  I don't know if any of them bothered
going to court, simply making the source available (on a cd
or webserver) is so much cheaper than that.

>Maybe the best attack angle would be to say that if a GPL system is
>interacting directly with a customer, then the source code should be
>distributed. But I don't see if this requirement need changes in the GPL
>(I'm ain't no expert).
>  
>
An interesting thing about the GPL is that it talks about
"distributing copies", not about "selling or otherwise changing ownership".

"Distributing" a linux kernel embedded in a product owned by the
company doesn't change that.  Where the binary kernel go, the
source should go too (if requested).

Fortunately, this licencing term is so easy to satisfy that it'd be silly
to try to fight it. Stick the source on a webserver somewhere.  Provide
the URL in the accompagnying paper (or a README file if appropriate.)
If distributing cd's, consider sticking a tarball there.

Helge Hafting
