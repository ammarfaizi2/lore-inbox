Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273144AbRIWV2F>; Sun, 23 Sep 2001 17:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273176AbRIWV1z>; Sun, 23 Sep 2001 17:27:55 -0400
Received: from maild.telia.com ([194.22.190.101]:58108 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S273144AbRIWV1g>;
	Sun, 23 Sep 2001 17:27:36 -0400
Date: Sun, 23 Sep 2001 23:32:23 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10
Message-ID: <20010923233223.A4661@telia.com>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <01092312415107.01503@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01092312415107.01503@localhost.localdomain>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> wrote:

> Anybody care to venture an opinion why a menu for "Fusion MPT Device Support" 
> shows up between SCSI and Firewire in the main menu of make menuconfig, but I 
> can't get into it?  I press enter and the main menu just redraws.  My .config 
> is attached.  (Never hand-hacked, but carried forward from...  2.4.7, I 
> think.)

That's because "Fusion MPT Device Support" required an option that you have
not selected. It's a bug that the menu is displayed at all in that case of
course, but I'm not sure CML1 can handle it.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
