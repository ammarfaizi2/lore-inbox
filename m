Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVANPNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVANPNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 10:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVANPNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 10:13:16 -0500
Received: from main.gmane.org ([80.91.229.2]:444 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262006AbVANPNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 10:13:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: jtjm@xenoclast.org (Julian T. J. Midgley)
Subject: Re: thoughts on kernel security issues
Date: Fri, 14 Jan 2005 15:12:58 +0000 (UTC)
Message-ID: <cs8nhp$j2d$1@sea.gmane.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050114102249.GA3539@wiggy.net> <cs8cqv$jo5$1@sea.gmane.org> <871xcoxduk.fsf@deneb.enyo.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: hanjague.menavaur.org
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: jtjm@skaffen.home.xenoclast.org (Julian T. J. Midgley)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <871xcoxduk.fsf@deneb.enyo.de>,
Florian Weimer  <fw@deneb.enyo.de> wrote:
>* Julian T. J. Midgley:
>
>>>vendor suffer from that as well. Suppose vendors learn of a problem in
>>>a product they visibly use such as apache or rsync. If all vendors
>>>suddenly update their versions or disable things that will be noticed as
>>>well, so vendors can't do that.
>>
>> I don't buy that at all.  There are numerous reasons for updating
>> programs or disabling things, of which fixing security holes is but
>> one.
>
>People used to monitor large name servers run by the in-crowd for
>synchronous updates, to get advance notice of the existence of BIND
>security holes.  AFAIK, it was a reliable indicator.

It might well have been - did these people then trawl through the BIND
sources to try to find the bug itself, and frequently develop an
exploit before the official patches were released?  If so, why didn't
they just assume that there was a bug in BIND and go looking for it
instead of waiting for circumstantial evidence that there mighe be
before they started looking.  

You'll have to explain why leaking the information "that there is a
bug in $PROGRAM", by fixing it (without disclosing either the bug or
the fix), is a problem.  After all, you can assume that for every
black hat foolish enough to sit around waiting for some evidence that
a bug exists before trying to find it, there'll be another that just
went looking anyway and has already found it.  It's better for all
concerned that the vendors protect themselves against the latter bunch
as soon as they reasonably can.

Julian
-- 
Julian T. J. Midgley                       http://www.xenoclast.org/
Cambridge, England.
PGP: BCC7863F FP: 52D9 1750 5721 7E58 C9E1  A7D5 3027 2F2E BCC7 863F

