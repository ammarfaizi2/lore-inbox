Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424919AbWKQVcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424919AbWKQVcc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755928AbWKQVcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:32:32 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:19901 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755917AbWKQVcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:32:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=D73RZ//Vyn7UyBT6rot8O4Jo0nH5mq4PsFmhTlHIZomZ1IgocEEAevt0sq3rR7Da7UyAgAhJQwE153u5IfQqNyJIx+KGHWGbVzJIeOcdPkuL/DPgVq9j9EFToD/ES+zNn4aIxQw1zVrin8DR9nmmqN/hGqIqt7cgDWyPgsGcouU=  ;
X-YMail-OSG: nsftmFkVM1niRi8M3n3ZcVYytYlaiHQeRKho4J.sqYlYN3H027LFMKu.H5UaZMOzCbICtZS6xw.hoYzffo2F04CkOhBJlIZxtaSU60gxTwaJagcf_Xy7
From: David Brownell <david-b@pacbell.net>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.19-rc6] platform_driver_probe(), can save codespace
Date: Fri, 17 Nov 2006 12:26:57 -0800
User-Agent: KMail/1.7.1
Cc: "Greg KH" <greg@kroah.com>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <200611162328.47987.david-b@pacbell.net> <200611171048.33086.david-b@pacbell.net> <d120d5000611171111g51f624a6mb9ad694005f690a8@mail.gmail.com>
In-Reply-To: <d120d5000611171111g51f624a6mb9ad694005f690a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171226.57794.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 11:11 am, Dmitry Torokhov wrote:

> Do we discard __init sections in modules nowadays? I thought we did
> that only for the kernel image itself.

When did we _not_ discard them for modules?
