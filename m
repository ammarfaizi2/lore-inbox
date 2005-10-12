Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVJLI3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVJLI3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 04:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVJLI3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 04:29:04 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:51023 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751359AbVJLI3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 04:29:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=JSwfocnRhvRyj7EJTm0AEstN6ISwH6dkmWdjd4fzrG4Dt8V6H1DK8CtT/fLY19J7JMmyqY1WUW5/yqYUi6U0K7bxQwHEKyf26+cT59178yYCals5N28RX8C34YMaEPucI9mq5L82af69shXFn0T97XiMtcGur7eU9KhlRSKSEUM=  ;
Date: Wed, 12 Oct 2005 10:27:07 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Borislav Petkov <bbpetkov@yahoo.de>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tgraf@suug.ch,
       pablo@eurodev.net
Subject: Re: [was: Linux v2.6.14-rc4] fix textsearch build warning
Message-ID: <20051012082707.GA26865@gollum.tnic>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org> <20051011145454.GA30786@gollum.tnic> <20051011205949.GU7992@ftp.linux.org.uk> <20051011230233.GA20187@gollum.tnic> <Pine.LNX.4.64.0510111629490.14597@g5.osdl.org> <Pine.LNX.4.64.0510111634070.14597@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510111634070.14597@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 04:38:14PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 11 Oct 2005, Linus Torvalds wrote:
> > 
> > HOWEVER. What you actually want to see is probably
> > 
> > 	git-diff-tree -p --pretty dd0fc66
> > 
> > which shows the commit as "patch" (-p) and a "pretty header" (--pretty).
> 
> Oh, and in the (more common) case when you don't actually know the commit 
> ID, just the file that was changed, do
> 
> 	git-whatchanged -p include/linux/textsearch.h
> 
> which shows only the commits (and the _parts_ of those commits) that 
> change that particular file (or list of files: you don't have to limit 
> yourself to just one file - you can track a whole directory or an 
> arbitrary list of files/directories).
> 
> And no, my tree doesn't contain your patch. My tree just contains Al's 
> first part, that added the typedef and replaced the existing users of 
> "unsigned int __nocast gfp_mask" to use that typedef.

You're right, hm, it was too late yesterday so i might have been dreaming
already :)) Anyways, thanks for the git crash course.

Regards,
		Boris.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
