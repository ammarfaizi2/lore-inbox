Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSEMKSp>; Mon, 13 May 2002 06:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSEMKSo>; Mon, 13 May 2002 06:18:44 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:47365 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S311320AbSEMKSo>; Mon, 13 May 2002 06:18:44 -0400
Date: Mon, 13 May 2002 12:17:57 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513101757.GB4071@louise.pinerecords.com>
In-Reply-To: <20020512203103.GA9087@gallifrey> <Pine.LNX.4.44.0205121836320.15555-100000@home.transmeta.com> <20020513101228.GA4071@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 15:30)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Tomas Szepe <szepe@pinerecords.com>, May-13 2002, Mon, 12:12 +0200]
> > [Linus Torvalds <torvalds@transmeta.com>, May-12 2002, Sun, 18:56 -0700]
> >
> > As an example, if the long version looks like this:
> > ...
> > The short version could look like
> > ...
> 
> How's this? (script attached)

hmmm, forgot to remove this one before submitting (not that it hurts)...

--- fmtcl.pl~	Mon May 13 12:15:51 2002
+++ fmtcl.pl	Mon May 13 12:15:56 2002
@@ -51,7 +51,7 @@
 	while ($_ = shift @items) {
 		# Item separator
 		print "\t--------------------------------------------------------------\n";
-		my $line; foreach $line (@$_) { print "$line"; }
+		print @$_;
 	}
 }
