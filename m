Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVI0R2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVI0R2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVI0R2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:28:09 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:25219 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965020AbVI0R2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:28:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=4+gFTOpsiB1WV9+/+HArCZRVu7CX8tfmN6bGKzXyjDSN5ZA72pJ0o8RJf24TtHibiO3EVTLF1LxWfYNQVyzCEsMZ0pcGiYBngpwKERCl3gTsk88q5Gh4qpJTcd2DE1p4qHIBEItWJp8mW2chdqtk5gAPmVTLMnt7a3Xahz0eBpM=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Writing on DM snapshots, and having no "mainstream" device (was: Re: Fw: [PATCH 1/7] Add dm-snapshot tutorial in Documentation)
Date: Mon, 26 Sep 2005 17:03:01 +0200
User-Agent: KMail/1.8.2
Cc: Alasdair G Kergon <agk@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-user@lists.sourceforge.net
References: <20050920163433.6081be3b.akpm@osdl.org> <200509232211.32238.blaisorblade@yahoo.it> <20050923211953.GG18976@agk.surrey.redhat.com>
In-Reply-To: <20050923211953.GG18976@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261703.01567.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 September 2005 23:19, Alasdair G Kergon wrote:
> On Fri, Sep 23, 2005 at 10:11:31PM +0200, Blaisorblade wrote:
> > you can create snapshots *WITHOUT* having a snapshot-origin device

> Checking the code, yes you're correct.
> When that LVM2 code was developed you'd get an oops but it's been fixed.
You also "fixed" my assertion that snapshot-origin "base device" (parameter 
n.1) must be a DM device. Should I readd it too?

IIRC I checked the code and it looks up the first param as a DM device, even 
because the list of snapshot is maintained for DM devices, not for general 
block devices.

Right?
> Alasdair

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
