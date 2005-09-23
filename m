Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVIWUMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVIWUMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVIWUMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:12:39 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:27220 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751216AbVIWUMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:12:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Mn7KzVKL22O0liDPhSraZtzubR60WjKvfWBDht2cFo5MODNP0YH2yGn7NMybTkBaUi8TLmsZHQ2ZnQ0sHt/PVpJpQfcl4B7eLiJ8RugAkpAcOVLNz7aGkjN3U1BWFMisnxItO8xuRbwCQMPPvLQtKaCQYvKTJpQ9dWO0epAb9Z4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Alasdair G Kergon <agk@redhat.com>
Subject: Writing on DM snapshots, and having no "mainstream" device (was: Re: Fw: [PATCH 1/7] Add dm-snapshot tutorial in Documentation)
Date: Fri, 23 Sep 2005 22:11:31 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net,
       user-mode-linux-user@lists.sourceforge.net
References: <20050920163433.6081be3b.akpm@osdl.org> <20050921154846.GW18976@agk.surrey.redhat.com>
In-Reply-To: <20050921154846.GW18976@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509232211.32238.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 17:48, Alasdair G Kergon wrote:
> On Tue, Sep 20, 2005 at 04:34:33PM -0700, Andrew Morton wrote:
> > ack?
>
> Applied some quick corrections to this.
I'm now looking at this, but you've done an error. You say that 

You must create the snapshot-origin device before you can create snapshots.

This is totally wrong. The whole point of my document is to show that you can 
create snapshots *WITHOUT* having a snapshot-origin device (yes, I did it).

And while the LVM setup (with snapshot-origin) is often used and well known, 
the possibility to do without the snapshot-origin, and more important to 
write on the snapshots, is something which is not widely known at all.

In fact, UML community has been using an in-house version of the same feature, 
which cannot be mounted on the host due to missing code.
> See also http://people.redhat.com/agk/talks/FOSDEM_2005/
> (slides 15-27)
Not yet had time to look at those, sorry.
> You might like to convert some of those diagrams to ASCII
> and include them?
If you feel like doing this, ok, but I'm not normally a documentor.
> Alasdair

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
