Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265564AbUAMTNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265575AbUAMTNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:13:30 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:61651 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265564AbUAMTN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:13:29 -0500
Date: Tue, 13 Jan 2004 19:12:17 +0000
From: Dave Jones <davej@redhat.com>
To: Jonathan Angliss <jon@netdork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: athlon-xp header issue
Message-ID: <20040113191217.GA29400@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jonathan Angliss <jon@netdork.net>, linux-kernel@vger.kernel.org
References: <398633829.20040113113000@netdork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398633829.20040113113000@netdork.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 11:30:00AM -0600, Jonathan Angliss wrote:

 > This gave me a hint. So I took a look in arch/i386/config.in and
 > noticed that the check for CONFIG_MK7XP is missing. This results in
 > the appropriate settings not being set. Is this intentional? Or am I
 > looking in the wrong area for my problem?

CONFIG_MK7XP is a gentoo specific bogon. Bug them about it.
(For info on why its bogus, search the linux-kernel archives,
 as it comes up every few months.)

		Dave

