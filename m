Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWDYIwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWDYIwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWDYIwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:52:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53953 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751476AbWDYIwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:52:40 -0400
Date: Tue, 25 Apr 2006 10:52:38 +0200
From: Martin Mares <mj@ucw.cz>
To: Avi Kivity <avi@argo.co.il>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       "J.A. Magallon" <jamagallon@able.es>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
Message-ID: <mj+md-20060425.085030.25134.atrey@ucw.cz>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com> <mj+md-20060424.201044.18351.atrey@ucw.cz> <444D44F2.8090300@wolfmountaingroup.com> <1145915533.1635.60.camel@localhost.localdomain> <20060425001617.0a536488@werewolf.auna.net> <1145952948.596.130.camel@capoeira> <444DE0F0.8060706@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444DE0F0.8060706@argo.co.il>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> That seems to be a case against writing functions.
> 
> Why is a C function acceptable where a C++ constructor isn't?

Because examining a single constructor is not enough -- you need to
check constructors of all objects contained within the object you
initialize.

Calling a C function is simple and explicit -- a quick glance over
the code is enough to tell what gets called.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Man is the highest animal. Man does the classifying.
