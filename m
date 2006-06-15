Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWFOFs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWFOFs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 01:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWFOFs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 01:48:56 -0400
Received: from gw.goop.org ([64.81.55.164]:61673 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932436AbWFOFs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 01:48:56 -0400
Message-ID: <4490F4BC.1040300@goop.org>
Date: Wed, 14 Jun 2006 22:48:44 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: George Nychis <gnychis@cmu.edu>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom support with thinkpad x6 ultrabay
References: <4490E776.7080000@cmu.edu>
In-Reply-To: <4490E776.7080000@cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Nychis wrote:
> I am looking for support somewhere in the kernel for my thinkpad x6
> ultrabay's cdrom drive.  Whenever I attach the ultrabay it picks up the
> extra usb ports, seems to pick up the ethernet port, but it fails to
> pick up anything about the dvd/cd-writer.  Nothing shows up in dmesg
> about the drive at all... anyone know what I might need in the kernel?
> I am using 2.6.17-rc6
-mm has some support for the dock, but there isn't support for hot 
add/remove of the optical device yet.  I think that's waiting on some 
support in libata, but I'm not exactly sure what's needed.

At the moment, you either get the dock optical if you boot the machine 
in the dock, and you can never eject the dock, or you get no optical and 
eject works fine.

    J
