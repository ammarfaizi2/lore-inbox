Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291539AbSBHKuq>; Fri, 8 Feb 2002 05:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291547AbSBHKug>; Fri, 8 Feb 2002 05:50:36 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:5645 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S291539AbSBHKuV>; Fri, 8 Feb 2002 05:50:21 -0500
Date: Fri, 8 Feb 2002 11:50:02 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org,
        netfilter-devel@lists.samba.org, hpa@zytor.com
Subject: Re: [SOLUTION] Re: Fw: 2.4.18-pre9: iptables screwed?
Message-ID: <20020208105001.GE12130@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20020208.010839.112626203.davem@redhat.com> <20020208105548.P26676@sunbeam.de.gnumonks.org> <20020208101218.GD12130@come.alcove-fr> <20020208113014.Q26676@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020208113014.Q26676@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 11:30:14AM +0100, Harald Welte wrote:

> Well, it is a bug in the debugging code, yes.  We missed to updated the
> debugging code when changing the mangle table.  The reason for this is
> that not even the developers are using the debugging code.

One may wonder then who is using this debugging code... :-)
Especially when you must pass an option to the cc line to _disable_ it...

> I'm not going to pull this change back out of the kernel because
> one (or more) distributors/vendors ship a compiled-with-debug iptables. 

Of course, never said that.

> I don't think this was by RedHat's intention. 

I don't think so, and anyway, the latest kernel is not supported 
officially by RedHat either. When (if) they release an updated kernel
containing the mangle patch, they will need to update the iptables
userspace tools too. That's all.

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
