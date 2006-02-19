Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWBSKqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWBSKqp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 05:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWBSKqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 05:46:45 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:5776 "EHLO sunrise.pg.gda.pl")
	by vger.kernel.org with ESMTP id S932393AbWBSKqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 05:46:44 -0500
Date: Sun, 19 Feb 2006 11:45:25 +0100
From: Adam Tla/lka <atlka@pg.gda.pl>
To: Thomas Dickey <dickey@his.com>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>, torvalds@osdl.org,
       bug-ncurses@gnu.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
Message-ID: <20060219104525.GC862@sunrise.pg.gda.pl>
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72A1E.1090707@ums.usu.ru> <43F7310E.4070109@pg.gda.pl> <20060218204040.B36972@mail101.his.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060218204040.B36972@mail101.his.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 08:43:56PM -0500, Thomas Dickey wrote:
> On Sat, 18 Feb 2006, Adam TlaÅ~Bka wrote:
> >one proper definition of the linux console. Maybe kernel developers should 
> >prepare some most compatible and acceptable one.
> >I can post the one I am using today:
> 
> ...of course, this one isn't like any of the variations I've seen.
> But you knew that.  (Aside from the acs/enacs/rmacs/smacs changes,
> I'm curious what happened to ich/ich1).

They were removed because of possible incompatibility warning.
Maybe they should stay - I posted only currently used by me linux terminal
definition. As I said before there should be the official linux terminal
definition and description included with kernel sources because vt.c
in sources defines console behaviour.

Anyway acs, enacs, smacs and rmacs sequences are defined here 
to stick to the controls interpretation used in vt.c 
do_con_trol function and to get desired behaviour.

Regards
-- 
Adam Tla³ka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
