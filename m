Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291741AbSBNQIX>; Thu, 14 Feb 2002 11:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291742AbSBNQIG>; Thu, 14 Feb 2002 11:08:06 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:55443 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S291741AbSBNQHt>; Thu, 14 Feb 2002 11:07:49 -0500
Date: Thu, 14 Feb 2002 17:07:48 +0100
From: bert hubert <ahu@ds9a.nl>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, torvalds@transmeta.com
Subject: Re: setuid/pthread interaction broken? 'clone_with_uid()?'
Message-ID: <20020214170748.B17490@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org,
	drepper@redhat.com, torvalds@transmeta.com
In-Reply-To: <20020214165143.A16601@outpost.ds9a.nl> <38300000.1013702447@baldur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <38300000.1013702447@baldur>; from dmccr@us.ibm.com on Thu, Feb 14, 2002 at 04:03:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 04:03:47PM +0000, Dave McCracken wrote:

> It's the expected behavior for a task-based model like Linux.  Each task is
> independent and inherits the uid/gid from whoever called clone().  It's
> just one of several resources that are specified as process-wide in POSIX,
> but are per-task in Linux.

Could this also be solved by making threads call 'clone' themselves? 

> I've been working on a patch to allow clone() to specify shared
> credentials, but it's been on the back burner.

Would be much appreciated.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
