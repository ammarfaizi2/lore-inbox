Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTFYJfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 05:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTFYJfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 05:35:12 -0400
Received: from cmu-24-35-32-166.mivlmd.cablespeed.com ([24.35.32.166]:3076
	"EHLO lap.molina") by vger.kernel.org with ESMTP id S262578AbTFYJfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 05:35:09 -0400
Date: Wed, 25 Jun 2003 05:47:27 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@lap.molina
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compaq Presario and 2.5.72
In-Reply-To: <20030623100345.C23411@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306250542300.1007-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003, Russell King wrote:

> On Wed, Jun 18, 2003 at 06:07:05AM -0600, Thomas Molina wrote:
> > The other problem was getting my pcmcia ethernet card up and operational.  
> > The change in the yenta module for the latest bk version of 72 allows it 
> > to be autoloaded by my RedHat 8.0 system as previously done.  However, 
> > there is another problem.  Although all the required modules get loaded -- 
> > pcmcia core, yenta socket, ds, crc32, tulip -- for some reason the dhcp 
> > client doesn't get brought up to acquire an address for the interface.  It 
> > may be a problem with the RedHat scripts since running the dhclient 
> > software manually does its magic.  It is a change in behaviour so I am 
> > reporting it here also.
> 
> Can you check whether 2.5.73 fixes it for you?  If not, please re-report
> the problem.

The problem persisits in the latest bk pull of 2.5.73.  All the modules 
get autoloaded, but, for some reason, the dhcp client doesn't get called.  
I apologize for not having a better report.  I will look into it as I have 
time.

