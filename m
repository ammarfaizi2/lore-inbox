Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbTI2HTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 03:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbTI2HTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 03:19:20 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:23936
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262841AbTI2HTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 03:19:18 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: public@mikl.as, linux-kernel@vger.kernel.org
Subject: Re: Linksys WRT54G: Part 2
Date: Mon, 29 Sep 2003 01:03:16 -0500
User-Agent: KMail/1.5
References: <200309281914.24869.public@mikl.as>
In-Reply-To: <200309281914.24869.public@mikl.as>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309290103.17004.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 September 2003 18:14, Andrew Miklas wrote:

> Previously, it was thought that the WRT54G source releases had only
> neglected to include the source code for the various kernel modules
> used to run the ethernet and wireless interfaces.  However, at this
> time, it is clear that the kernel proper of the WRT54G itself has had
> functionality added to it.  This functionality is not present in the
> kernel code that Linksys has provided at their "GPL Code Center".

It's probable that Linksys itself didn't know this.  (They wouldn't go to the 
trouble of creating a GPL Code Center to post knowingly incomplete code.)

At every proprietary softare company I've ever worked for, and this sort of 
knowledge was limited to one or two individual engineers, who often left the 
project when it shipped.  The support guys often don't know diddly, and 
management is seldom even aware how much there IS to know.

Keep the pressure up, but be nice and give them some time to audit their 
codebase.  Firmware development was probably outsourced to india or taiwan or 
something, and Linksys (nee Cisco) is quite possibly furious at whoever they 
outsourced this to for putting them in this position in the first place...

> It is also worth noting that this is not the only Linksys device that
> uses Linux and other software licensed under the GPL without adhering
> to the license.  For example, the Samba team has expressed some
> concern over the use of Samba in the Linksys EFG80 network accessible
> storage device [5].

And there will be more in the future.  Proprietary software companies aren't 
used to having _access_ to code without the obigations for using it already 
having been discharged.  (Usually up-front cash payments, although sometimes 
it's a percentage of revenues, and sometimes it's bartering for other code or 
bundling deals or whatever.)

And even though many of them then go on and violate that license six ways from 
sunday afterwards (by simply not caring in the rush to ship), they're not 
used to being called on it afterwards.  Open source doesn't just do 
distributed development and debugging better than the proprietary guys, we do 
distributed license auditing. :)

Query: should this kind of thing have its own mailing list?  There are a 
number of organizations that might want to pool their resources on these 
issues (off the top of my head, OSI, Linux International, and OSDL spring to 
mind.  The FSF would also be a logical candidate, if logic applied to the 
FSF, but the absence of ftp.gnu.org/pub/decss strongly implies it doesn't.)

> Unfortunately, neither group knows how to proceed in obtaining this
> code.  While Linksys has shown some interest in releasing the source
> for software licensed under the GPL, they have not responded to the
> issues outlined in this post.

Most likely, management hasn't budgeted the man hours to audit the rest of 
their codebase yet.  I'd guess they just want to do the minimum amount of 
work to make the problem go away, and probably thought they already had...

> [1] Linksys GPL Code Center
> http://www.linksys.com/support/gpl.asp

There's an Alanis Morisette song about Active Server Pages devoted to GPL 
code...

Rob


