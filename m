Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261672AbTCQAXM>; Sun, 16 Mar 2003 19:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261674AbTCQAXM>; Sun, 16 Mar 2003 19:23:12 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:270 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S261672AbTCQAXL>;
	Sun, 16 Mar 2003 19:23:11 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Sun, 16 Mar 2003 16:33:58 -0800
To: Thomas Hood <jdthood0@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org, achirica@users.sourceforge.net
Subject: Re: Cisco Aironet 340 oops with 2.4.20
Message-ID: <20030316163358.A25887@jose.vato.org>
Mail-Followup-To: Tim Pepper <tpepper>, Thomas Hood <jdthood0@yahoo.co.uk>,
	linux-kernel@vger.kernel.org, achirica@users.sourceforge.net
References: <1047751880.4798.4.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1047751880.4798.4.camel@thanatos>; from jdthood0@yahoo.co.uk on Sat, Mar 15, 2003 at 07:11:20PM +0100
X-PGP-Key: http://vato.org/~tpepper/pubkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a caveat to my previously posted 'works for me'.  Before I'd
notice that my net connection was no longer moving and then see the oops
in my log if I looked.	With the cvs driver I still tend to see that my
net connection dies sometimes, but no oops.  I've found hotplugging the pcmcia
card brings it back to life.

It seems like I hit this with either driver primarily if I've put my
laptop to sleep earlier in its current uptime.  Is there possibly a
deadlock somewhere around the previously oopsing code and/or the airo_cs
interaction with apm?

t.
-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
