Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264546AbUFJJqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUFJJqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 05:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUFJJqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 05:46:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:22153 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264562AbUFJJIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 05:08:10 -0400
Subject: Re: [STACK] >3k call path in reiserfs
From: Vladimir Saveliev <vs@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Chris Mason <mason@suse.com>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40C75273.7020508@namesys.com>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>
	 <1086784264.10973.236.camel@watt.suse.com>
	 <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com>
	 <20040609172843.GB2950@wohnheim.fh-wedel.de> <40C75273.7020508@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1086858488.25768.30.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 10 Jun 2004 13:08:09 +0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2004-06-09 at 22:09, Hans Reiser wrote:
> Jörn Engel wrote:
> 
> >On Wed, 9 June 2004 10:06:16 -0700, Hans Reiser wrote:
> >  
> >
> >>Can you give me some background on whether this is causing real problems 
> >>for real users?
> >>    
> >>
> >
> >It's not [yet].  This was done with statical analysis and keeping a
> >little extra room for safety.  If you prefer to wait for real bug
> >reports, go ahead...
> >
> >...but note that my signature ai has proven it's merits once again...
> >  
> >
> what is your signature ai?
> 
> >Jörn
> >
> >  
> >
> Unless it is really necessary, or a small code change, I would prefer to 
> spend our cycles worrying about this in reiser4, 

it will not be easy to make reiser4 to work with 4k stack

> because code changes in 
> V3 are to be avoided if possible.
> 
> I am open to arguments that it is really necessary.
> 

