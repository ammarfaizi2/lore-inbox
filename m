Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTJNPGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 11:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTJNPGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 11:06:25 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:27009 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262564AbTJNPGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 11:06:23 -0400
Date: Tue, 14 Oct 2003 17:06:15 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Shawn Willden <shawnfu@willden.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs -- docbook-utils
Message-ID: <20031014170615.A5704@beton.cybernet.src>
References: <20031014120946.A4969@beton.cybernet.src> <Pine.LNX.4.44.0310142106220.16081-100000@diskbox.stillhq.com> <20031014154411.A5373@beton.cybernet.src> <200310140842.57178.shawnfu@willden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200310140842.57178.shawnfu@willden.org>; from shawnfu@willden.org on Tue, Oct 14, 2003 at 08:42:56AM -0600
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 08:42:56AM -0600, Shawn Willden wrote:
> On Tuesday 14 October 2003 07:44 am, Karel Kulhavý wrote:
> 
> > Please supply either a guide how to compile HTML docs for kernel into
> > README or a pointer to it INCLUDING SETTING UP DOCBOOK STYLESHEETS ON
> > USER'S MACHINE
> 
> Please write such a guide after you figure out how to do it and submit it 
> as a patch.
> 
> Be part of the solution, not part of the problem.  Otherwise, you're 
> certainly free to use one of the other operating systems that have been 
> recommended.  Threats and bluster won't get you any further than whining.  
> A bit of work on your own, on the other hand, will get you what you want, 
> and a willingness to share is a great way to show appreciation for what 
> others have given you for free.

OK, I agree with you. This is what my ideal world of free software looks like
:) 

I am trying to figure out the guide but ran into numerous problems.

First I tried to install the sources of docbook-utils from Debian
sources, either with or without their patch. Neither of them installs the required db2html
script db2html.

Then I tried to install docbook-utils-0.6.13 from freshmeat.net's docbook-utils
entry.  It required jade (some kind of UNIX editor) jade required librep (LISP
interpreter and virtual machine) librep first seemed to require gmp but then I
discovered it can be built without GMP

Having installed librep and jade, I tried to compiile the docbook-utils-0.6.13
but it crashes during make on cryptic message:

make[2]: Entering directory `/home/clock/docbook-utils-0.6.13/doc/HTML'
SGML_CATALOG_FILES=/etc/sgml/catalog \
SGML_SEARCH_PATH=../..:../../doc:.. \
        jade -t sgml -i html -d ../../docbook-utils.dsl\#html \
                -V '%use-id-as-filename%' ../../doc/docbook-utils.sgml
make[2]: *** [api.html] Error 5
make[2]: Leaving directory `/home/clock/docbook-utils-0.6.13/doc/HTML'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/clock/docbook-utils-0.6.13/doc'
make: *** [all-recursive] Error 1

Do you have any suggestion what it could be? All the prerequisites
seem to be installed.

Cl<
> 
> In case it may be of assistance, I have attached the db2html script from my 
> system.
> 
> Shawn.


