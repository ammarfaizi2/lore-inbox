Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269535AbRHCSLY>; Fri, 3 Aug 2001 14:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269540AbRHCSLO>; Fri, 3 Aug 2001 14:11:14 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:38154 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269535AbRHCSLF>; Fri, 3 Aug 2001 14:11:05 -0400
Date: Fri, 3 Aug 2001 20:11:12 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010803201112.D31468@emma1.emma.line.org>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080316082001.01827@starship> <20010803111803.B25450@cs.cmu.edu> <01080317471707.01827@starship> <20010803165036.C12470@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010803165036.C12470@redhat.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Stephen Tweedie wrote:

> > We don't need all the paths, and not any specific path, just a path.
> 
> Exactly, because fsync makes absolutely no gaurantees about the
> namespace.  So a lost+found path is quite sufficient.

MTA authors don't share this. lost+found is "invisible" for the
application that created the file.

I have yet to meet a distribution which scans lost+found at boot time
and syslogs found files or sends root a mail.

So, effectively, lost+found will NOT be sufficient. Discarding file
names at will is not a good thing.

-- 
Matthias Andree
