Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTK3Vh3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 16:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTK3Vh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 16:37:29 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:22705 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263228AbTK3Vh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 16:37:27 -0500
Date: Sun, 30 Nov 2003 21:30:52 +0000
From: Dave Jones <davej@redhat.com>
To: Brad House <brad_mssw@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test11] agpgart [amd64] fix (off by one)
Message-ID: <20031130213052.GA10414@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brad House <brad_mssw@gentoo.org>, linux-kernel@vger.kernel.org
References: <35356.68.105.173.45.1070219694.squirrel@mail.mainstreetsoftworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35356.68.105.173.45.1070219694.squirrel@mail.mainstreetsoftworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 02:14:54PM -0500, Brad House wrote:
 > AGPGart would report "Too many northbridges" without this
 > patch. The problem was that 'i' was incremented before being
 > checked against the MAX GARTS, just making the check > instead
 > of == fixes the problems.  Patch here:

Already fixed slightly differently in agpgart bitkeeper tree.
I've been trying to get Linus to take this and a few other
similar bits for a while, but they just haven't been 
important enough I guess, so its probably post 2.6.0 material.

		Dave

