Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269708AbUINUSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269708AbUINUSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269747AbUINUPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:15:21 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:45579 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S269765AbUINUMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:12:20 -0400
Date: Tue, 14 Sep 2004 21:12:10 +0100
From: Dave Jones <davej@redhat.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Message-ID: <20040914201210.GE13788@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <41474B15.8040302@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41474B15.8040302@nortelnetworks.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 01:48:37PM -0600, Chris Friesen wrote:
 > 
 > Its kind of offtopic, but I hoped that someone might have some pointers 
 > since the kernel developers deal with so many patches.
 > 
 > I've been given a massive kernel patch that makes a whole bunch of 
 > conceptually independent changes.
 > 
 > Does anyone have any advice on how to break it up into independent patches?

diffsplit will split it into a patch-per-file, which could be
a good start. If you have multiple changes touching the same file
however, things get a bit more fun, and you get to spend a lot
of time in your favorite text editor glueing bits together.

		Dave

