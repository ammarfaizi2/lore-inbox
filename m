Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267885AbTB1OJN>; Fri, 28 Feb 2003 09:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbTB1OJN>; Fri, 28 Feb 2003 09:09:13 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:18472 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S267885AbTB1OJL>; Fri, 28 Feb 2003 09:09:11 -0500
Date: Fri, 28 Feb 2003 16:19:18 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Protecting processes from the OOM killer
Message-ID: <20030228141917.GF159052@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E5EB9A8.3010807@kegel.com> <1046439618.16599.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046439618.16599.22.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 01:40:19PM +0000, you [Alan Cox] wrote:
> 
> How about by not allowing your system to excessively overcommit.
> Everything else is armwaving "works half the time" stuff. 

Which invites the question: the strict overcommit stuff from -ac (the 'echo
{2,3} > /proc/sys/vm/overcommit_memory' stuff) hasn't found it's way to
mainline yet, has it? I wonder if it would be compatible with up-to-date
-aa vm...


-- v --

v@iki.fi
