Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVGRLVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVGRLVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGRLVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:21:55 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:40660 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261188AbVGRLVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:21:53 -0400
Subject: Re: Increasing virtual address space of a process, by treating
	virtual address's as offsets in secondary memory.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3faf056805071721422594dd20@mail.gmail.com>
References: <3faf056805071721422594dd20@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Jul 2005 12:45:52 +0100
Message-Id: <1121687153.12438.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-07-18 at 10:12 +0530, vamsi krishna wrote:
> I was searching a lot about work on this, and found your reply where
> you say that we can increase the virtual address space by mmaping and
> munmaping programatically ourself.

Its something a few giant applications do with data sets and the trick
of using shared memory segments works on most Linux or Unixlike systems.
It's almost a historical note now. With 64bit processors its no longer
worth the pain

