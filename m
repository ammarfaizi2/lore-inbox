Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTKCNaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 08:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTKCNaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 08:30:20 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:1673 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261667AbTKCNaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 08:30:16 -0500
Date: Mon, 3 Nov 2003 13:28:47 +0000
From: Dave Jones <davej@redhat.com>
To: Maciej Freudenheim <fahren@student.uci.agh.edu.pl>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, davej@codemonkey.org.uk,
       mochel@osdl.org
Subject: Re: Suspend and AGP in 2.6.0-test9
Message-ID: <20031103132847.GB25183@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Maciej Freudenheim <fahren@student.uci.agh.edu.pl>,
	linux-kernel@vger.kernel.org, pavel@ucw.cz, davej@codemonkey.org.uk,
	mochel@osdl.org
References: <20031103123441.GA770@student.uci.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031103123441.GA770@student.uci.agh.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 01:34:41PM +0100, Maciej Freudenheim wrote:

 > So, my question is - is it known (and not fixable :) bug or it's
 > something weird and shouldn't happen ? As fair as I googled for similar
 > problems I have found that people usually have problems with DRI, it looks
 > like agp works ok for most of them :) However, on my laptop disabling
 > DRI doesn't help.

Suspend/Resume code in agpgart is virtually non-existant.
I've not had chance to try suspend recently, but when I last looked
at it, it wasn't in a state that made debugging particularly easy.
(It's hard to see if you got things right, if it won't resume for eg).
I've not had chance to try it again more recently. It's possible
the various changes that have gone on over the last month or so have
improved the situation somewhat.

		Dave

