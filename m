Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTCFQ4z>; Thu, 6 Mar 2003 11:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268131AbTCFQ4z>; Thu, 6 Mar 2003 11:56:55 -0500
Received: from mail5.intermedia.net ([206.40.48.155]:62983 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id <S262289AbTCFQ4x>; Thu, 6 Mar 2003 11:56:53 -0500
Subject: Re: good info on memory management
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Prasad Kamath <prasadk@cisco.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046865827.11705.3.camel@pc-16.office.scali.no>
References: <20030305111015.B8883@flint.arm.linux.org.uk>
	<20030305111015.B8883@flint.arm.linux.org.uk>
	<4.3.2.7.2.20030305170551.02071098@cbin3-mira-01.cisco.com> 
	<1046865827.11705.3.camel@pc-16.office.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 06 Mar 2003 09:16:04 +0100
Message-Id: <1046938565.19978.6.camel@knoppix>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 13:03, Terje Eggestad wrote:
> There was a guy who had done this thesis on documenting the Linux VM. He
> posted an announcement on this list, I think it was in last dec
> sometime. Check the archive.
> 
> 
> On Wed, 2003-03-05 at 12:37, Prasad Kamath wrote:
> > Hi All,
> >        Where can I get a full documentation on the memory management (for 
> > linux)?
> > 
> > 
> > thanks & regards
> > Prasad Kamath
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> _________________________________________________________________________
> 
> Terje Eggestad                  mailto:terje.eggestad@scali.no
> Scali Scalable Linux Systems    http://www.scali.com
> 
> Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
> P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
> N-0619 Oslo                     fax:    +47 22 62 89 51
> NORWAY            
> _________________________________________________________________________
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Mel Gorman's thesis. He is/was at Univerisity of Limerick, Ireland. URL
does not always seem to work - sometimes it goes down and comes up a bit
later. Has happened twice to me.

"
The documentation comes in two parts. The first is "Understanding the
Linux Virtual Memory Manager" and it does pretty much as described. It
is available in three formats, PDF, HTML and plain text.

Understanding the Linux Virtual Memory Manager
PDF: http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/understand.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/understand/
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/understand.txt

The second part is a code commentary which is literally a guided tour
through the code. It is intended to help decipher the more cryptic
sections as well as identify the code patterns that are prevalent
through the code. I decided to have the code separate from the first
document as maintaining the code in the document would be too painful

Code Commentary on the Linux Virtual Memory Manager
PDF: http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/code.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/code
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/code.txt

Any feedback, comments or suggestions are welcome from anyone with a VM
interest but I would appreciate if people already familiar with the VM
would even give a brief read to check for technical accuracy. There was
rarely an authoritative source to check to make sure I was right and I
didn't want to be asking questions every 5 minutes on IRC or mailing
lists :-) 
"

-- 
Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/

The views, opinions, and judgements expressed in this message are solely
those of
the author. The message contents have not been reviewed or approved by
Zultys.

