Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbTDDLzM (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbTDDLzM (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:55:12 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:48061 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263685AbTDDLzD (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 06:55:03 -0500
Date: Fri, 4 Apr 2003 13:06:09 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Eric Raymond`s CML2 configuration generator
Message-ID: <20030404120452.GA12796@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Samium Gromoff <deepfire@ibe.miee.ru>, linux-kernel@vger.kernel.org
References: <20030404140410.52717dad.deepfire@ibe.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404140410.52717dad.deepfire@ibe.miee.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 02:04:10PM +0400, Samium Gromoff wrote:

 > 		The question is why the utterly beautiful generator was dropped?

overengineering, and not listening to the requests of people
that would spend the most time using it, instead pandoring to
the needs of figments of Erics imagination. The day Eric stopped
listening to kernel developers, kernel developers stopped listening
to Eric.

 > 		One of the obvious problems is that it was python-based, and thus being slow and
 > 		requiring python to be installed.
 > 		So what if it was written in C?

not an issue.

 > 		Is it possible for it to get in before 2.6?

no. we're well into freeze now, and ripping out something of
that size would be a major step backwards.
Besides, Roman Zippel's kconfig work got merged instead,
which is a large improvement over what we had in 2.4

		Dave
