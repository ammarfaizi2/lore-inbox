Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUHVWm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUHVWm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUHVWm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 18:42:28 -0400
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:32008 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S266805AbUHVWmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 18:42:25 -0400
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Linux Incompatibility List
Date: Mon, 23 Aug 2004 00:42:19 +0200
User-Agent: KMail/1.6.1
Cc: Wakko Warner <wakko@animx.eu.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org
References: <200408221643.i7MGhYT3004043@localhost.localdomain>
In-Reply-To: <200408221643.i7MGhYT3004043@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408230042.19716.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 August 2004 18.43, you wrote:
> does a distorted 1024x768), so I use nVidia's driver (which has its own
> problems, if you install it for one kernel it breaks for the others).

Instread of rerunning the full installer everytime you can use --extract-only. 
Then run the installer in and for new kernels cd down to 
<installerdir>/usr/src/nv and make install. That won't delete the
module for other kernels. If paranoid, touch *.c first.

-- robin
