Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVKURZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVKURZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKURZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:25:00 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51341
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932364AbVKURY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:24:58 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Tarkan Erimer <tarkane@gmail.com>
Subject: Re: Sun's ZFS and Linux
Date: Mon, 21 Nov 2005 11:24:48 -0600
User-Agent: KMail/1.8
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <9611fa230511181538g3e8ec403uafa9ed32b560fb0c@mail.gmail.com> <20051119172337.GA24765@thunk.org> <9611fa230511201312r5f43e8ady7023b4bde170596e@mail.gmail.com>
In-Reply-To: <9611fa230511201312r5f43e8ady7023b4bde170596e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211124.48398.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 15:12, Tarkan Erimer wrote:
> Thanks for the explanation. BTW, I wonder something: Is there any
> possibility to give GPL an exception to include and/or link to CDDL
> code?

No, and Sun likes it that way.

The GPL was the first "copyleft" style license which requires that derivative 
works be placed under exactly the same terms as the original work.  If the 
terms of another code are incompatible, they cannot be exactly the same.  

(Specifically, the GPL says in section 2b, "You must cause any work that you 
distribute or publish, that in whole or in part contains or is derived from 
the Program or any part thereof, to be licensed as a whole at no charge to 
all third parties under the terms of this License."  See 
"http://www.gnu.org/copyleft/gpl.html" and 
"http://www.fsf.org/licensing/licenses/index_html#GPLIncompatibleLicenses".)

Sun intentionally designed the CDDL to be incompatible with the GPL.  This was 
a design goal on Sun's part.*  They want to isolate themselves from the 
existing open source community, and make sure that their code cannot be used 
with the most common open source license.**  Why they want to do this has 
been widely speculated about***, but the fact they want an explicit "us vs 
them, no sharing" stance is not in dispute.

Rob

* See http://www.vnunet.com/vnunet/news/2127094/sun-slams-predatory-gpl or
http://news.com.com/Sun+criticizes+popular+open-source+license/2100-7344_3-5656047.html 
or http://www.adtmag.com/article.asp?id=10927 plus Sun's official rationale 
at http://www.sun.com/cddl/CDDL_why_details.html

** According to http://sourceforge.net/softwaremap/trove_list.php?form_cat=13 
there are currently 72,823 projects on sourceforge specifying a license.  Of 
those, 48050 have chosen to license their code under the GPL.  That's 65.98%, 
or about 2/3 of the total.  In politics, this would be flirting with a 
veto-proof majority.  David Wheeler did a detailed analysis at 
http://www.dwheeler.com/essays/gpl-compatible.html

*** see http://lwn.net/Articles/114839/ or http://lwn.net/Articles/159248/ or 
http://www.eweek.com/article2/0,1759,1754155,00.asp or 
http://www.eweek.com/article2/0,1895,1739000,00.asp or
http://searchopensource.techtarget.com/qna/0,289202,sid39_gci1060779,00.html 
or http://www.technewsworld.com/story/40176.html or 
http://www.vnunet.com/vnunet/news/2126648/sun-hits-back-open-source-critics
or...
