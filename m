Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752069AbWCGGxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbWCGGxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWCGGxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:53:21 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:31891 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752068AbWCGGxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:53:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cpnHUT+Zp2NO9fsdefivsYCDUUqqURbr1eJAmWJEvY/VSgjq0Wf1Mo254O1jMUXm8FrAq1yMiwvDC43Ff4BJNfYc1yubTGE2A2RlhttkPleHgudLu3OigbaEHE4Gvg1UrQZsw5QKh1f7ucaslGD2+4xP6bUZWyh+w9DVdedVfA8=  ;
Message-ID: <440D2DDA.7040209@yahoo.com.au>
Date: Tue, 07 Mar 2006 17:53:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, fabbione@ubuntu.com, Andrew Morton <akpm@osdl.org>
Subject: Re: VFS nr_files accounting
References: <20060305070537.GB21751@in.ibm.com> <20060304.233725.49897411.davem@davemloft.net> <20060305113847.GE21751@in.ibm.com> <20060306.123904.35238417.davem@davemloft.net> <20060307064120.GA5946@in.ibm.com>
In-Reply-To: <20060307064120.GA5946@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> On Mon, Mar 06, 2006 at 12:39:04PM -0800, David S. Miller wrote:

>>I think we should seriously consider these patches for 2.6.16
> 
> 
> Isn't it a little too late in the 2.6.16 cycle ? I would have
> liked a little more time in -mm. Anyway, it is Linus' call. 
> I can refresh the patches and submit against latest mainline
> if Linus and Andrew want.
> 

If it is making the machine unusable then it is a bug rather than
just poor behaviour, and definitely a regression.

I think this is very good grounds to get into 2.6.16, even if it
does mean pushing the release back.

The other thing that is typically done for regressions like these
close to release time is to revert the offending changes. I figure
that in this case, such an option is probably _more_ risky.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
